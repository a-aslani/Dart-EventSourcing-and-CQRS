import 'package:ddd_dart/ddd/domain/events/domain_event.dart';

class EmployeeNameUpdated extends DomainEvent {
  final String name;
  EmployeeNameUpdated({required this.name});
}