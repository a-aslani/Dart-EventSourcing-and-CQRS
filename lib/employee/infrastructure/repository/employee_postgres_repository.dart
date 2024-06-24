import 'package:ddd_dart/employee/contracts/employee_repository.dart';
import 'package:ddd_dart/employee/domain/entities/employee.dart';
import 'package:postgres/postgres.dart';

class EmployeePostgresRepository implements EmployeeRepository {

  final Connection conn;

  EmployeePostgresRepository(this.conn);

  @override
  Future<Employee> load(String id) async {

    final result = await conn.execute(
      r'SELECT * FROM employees WHERE id=$1 LIMIT 1',
      parameters: [id],
    );

    final data = result.first.toColumnMap();

    return Employee.create(id: data["id"], name: data["name"]);
  }

  @override
  Future<void> save(Employee employee) async {
    final parameters = [employee.id.toString(), employee.name!.value];

    final update = await conn.execute(
      r'UPDATE employees SET name=$2 WHERE id=$1;',
      parameters: parameters,
    );

    if (update.affectedRows == 0) {
      final create = await conn.execute(
        r'INSERT INTO employees (id, name) SELECT $1, $2 WHERE NOT EXISTS (SELECT 1 FROM employees WHERE id=$1);',
        parameters: parameters,
      );
    }
  }
}
