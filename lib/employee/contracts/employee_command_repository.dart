import 'package:ddd_dart/ddd/contracts/i_command_repository.dart';
import 'package:ddd_dart/employee/domain/entities/employee.dart';

abstract class EmployeeCommandRepository extends ICommandRepository<Employee, String> {}