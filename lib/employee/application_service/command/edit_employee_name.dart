import 'dart:io';

import 'package:ddd_dart/ddd/application_service/command_handler.dart';
import 'package:ddd_dart/ddd/application_service/i_command.dart';
import 'package:ddd_dart/ddd/application_service/service_failure.dart';
import 'package:ddd_dart/ddd/domain/exceptions/invalid_value_object_state_exception.dart';
import 'package:ddd_dart/employee/contracts/employee_command_repository.dart';

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
