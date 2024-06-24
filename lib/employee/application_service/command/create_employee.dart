import 'package:ddd_dart/ddd/application_service.dart';
import 'package:ddd_dart/ddd/domain/exceptions/invalid_value_object_state_exception.dart';
import 'package:ddd_dart/ddd/guid.dart';
import 'package:ddd_dart/employee/contracts/employee_repository.dart';
import 'package:ddd_dart/employee/domain/entities/employee.dart';

class CreateEmployee extends ApplicationService<Employee, CreateEmployeeParams> {

  final EmployeeRepository repository;

  CreateEmployee({required this.repository});

  @override
  Future<(Employee?, String?)> call(CreateEmployeeParams params) async {
    try {

      final employee = Employee.create(id: Guid.generate().toString(), name: params.name);

      await repository.save(employee);

      return (employee, null);

    } on InvalidValueObjectStateException catch(e) {
      return (null, e.message);
    } catch(e) {
      return (null, e.toString());
    }
  }
}

class CreateEmployeeParams {
  final String name;

  const CreateEmployeeParams({
    required this.name,
  });
}
