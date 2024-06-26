import 'package:ddd_dart/employee/contracts/employee_command_repository.dart';
import 'package:ddd_dart/employee/domain/entities/employee.dart';
import 'package:eda/application_service.dart';
import 'package:eda/eda.dart';
import 'package:eda/exceptions.dart';

class CreateEmployee
    extends CommandHandlerWithResponseData<CreateEmployeeCommand, Employee> {
  final EmployeeCommandRepository repository;

  CreateEmployee({required this.repository});

  @override
  Future<(Employee?, ServiceFailure?)> call(
    CreateEmployeeCommand command,
  ) async {
    try {
      final employee = Employee.create(
        id: Guid.generate().toString(),
        name: command.name,
      );

      await repository.save(employee);

      return (employee, null);
    } on InvalidValueObjectStateException catch (e) {
      return (
        null,
        ServiceFailure(
          message: e.message,
          code: e.code,
        )
      );
    } catch (e) {
      return (null, ServiceFailure(message: e.toString()));
    }
  }
}

class CreateEmployeeCommand implements ICommand {
  final String name;

  const CreateEmployeeCommand({
    required this.name,
  });
}
