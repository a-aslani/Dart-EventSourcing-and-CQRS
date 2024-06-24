import 'package:ddd_dart/ddd/domain/events/domain_event.dart';

class EmployeeCreated extends DomainEvent {
  final String id;
  final String name;
  EmployeeCreated({required this.id, required this.name});
}