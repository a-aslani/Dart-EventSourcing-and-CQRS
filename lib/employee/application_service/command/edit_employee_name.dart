import 'package:ddd_dart/ddd/application_service.dart';
import 'package:ddd_dart/ddd/domain/exceptions/invalid_value_object_state_exception.dart';
import 'package:ddd_dart/employee/contracts/employee_command_repository.dart';
import 'package:ddd_dart/employee/domain/entities/employee.dart';

class EditEmployeeName extends ApplicationService<Employee, EditEmployeeNameParams> {

  final EmployeeCommandRepository repository;

  EditEmployeeName({required this.repository});

  @override
  Future<(Employee?, String?)> call(EditEmployeeNameParams params) async {
    try {

      final employee = await repository.load(params.id);

      employee.editName(params.name);

      await repository.save(employee);

      return (employee, null);

    } on InvalidValueObjectStateException catch(e) {
      return (null, e.message);
    }
  }
}

class EditEmployeeNameParams {
  final String id;
  final String name;

  const EditEmployeeNameParams({
    required this.id,
    required this.name,
  });
}
