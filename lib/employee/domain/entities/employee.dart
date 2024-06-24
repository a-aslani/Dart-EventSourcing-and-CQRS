import 'package:ddd_dart/ddd/domain/entities/aggregate_root.dart';
import 'package:ddd_dart/ddd/domain/events/domain_event.dart';
import 'package:ddd_dart/ddd/domain/exceptions/invalid_event_state_exception.dart';
import 'package:ddd_dart/ddd/guid.dart';
import 'package:ddd_dart/employee/domain/domain_events/employee_created.dart';
import 'package:ddd_dart/employee/domain/domain_events/employee_name_updated.dart';
import 'package:ddd_dart/employee/domain/vo/employee_name.dart';

class Employee extends AggregateRoot<Guid> {

  EmployeeName? name;

  Employee.create({required String id, required String name}): super(id: Guid(id)) {
    apply(EmployeeCreated(id: id, name: name));
  }

  void editName(String name) {
    apply(EmployeeNameUpdated(name: name));
  }

  @override
  void on(DomainEvent event) {
    if (event is EmployeeCreated) {
      name = EmployeeName(event.name);
    } else if (event is EmployeeNameUpdated) {
      name = EmployeeName(event.name);
    } else {
      throw InvalidEventStateException(
          message: "{{0}} is a invalid event",
          parameters: [event.runtimeType.toString()]);
    }
  }
}
