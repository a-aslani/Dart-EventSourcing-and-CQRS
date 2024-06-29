import 'package:ddd_dart/employee/domain/domain_events/employee_created.dart';
import 'package:ddd_dart/employee/domain/domain_events/employee_name_updated.dart';
import 'package:ddd_dart/employee/domain/vo/employee_name.dart';
import 'package:eda/domain.dart';
import 'package:eda/eda.dart';
import 'package:eda/error.dart';
import 'package:eda/exceptions.dart';

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
          error: ErrorType("{{0}} is a invalid event").vars(
              params: [event.runtimeType.toString()],
          ),
      );
    }
  }
}
