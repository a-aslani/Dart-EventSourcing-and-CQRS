import 'package:ddd_dart/employee/domain/entities/employee.dart';

abstract class EmployeeRepository {
  Future<void> save(Employee employee);
  Future<Employee> load(String id);
}