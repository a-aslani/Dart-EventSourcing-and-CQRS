import 'package:ddd_dart/employee/domain/entities/employee.dart';
import 'package:eda/contracts.dart';

abstract class EmployeeCommandRepository extends ICommandRepository<Employee, String> {}