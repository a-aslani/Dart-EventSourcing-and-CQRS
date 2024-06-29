import 'package:eda/domain.dart';

class EmployeeCreated extends DomainEvent {
  final String id;
  final String name;
  EmployeeCreated({required this.id, required this.name});
}