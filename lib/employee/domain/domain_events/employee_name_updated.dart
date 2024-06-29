import 'package:eda/domain.dart';

class EmployeeNameUpdated extends DomainEvent {
  final String name;
  EmployeeNameUpdated({required this.name});
}