import 'package:ddd_dart/employee/contracts/employee_command_repository.dart';
import 'package:eda/application_service.dart';
import 'package:eda/exceptions.dart';

class EditEmployeeName extends CommandHandler<EditEmployeeNameCommand> {
  final EmployeeCommandRepository repository;

  EditEmployeeName({required this.repository});

  @override
  Future<ServiceFailure?> call(EditEmployeeNameCommand command) async {
    try {
      final employee = await repository.load(command.id);

      employee.editName(command.name);

      await repository.save(employee);

      return null;
    } on InvalidValueObjectStateException catch (e) {
      return ServiceFailure(
        message: e.message,
        code: e.code,
      );
    } catch (e) {
      return ServiceFailure(message: e.toString());
    }
  }
}

class EditEmployeeNameCommand implements ICommand {
  final String id;
  final String name;

  const EditEmployeeNameCommand({
    required this.id,
    required this.name,
  });
}
