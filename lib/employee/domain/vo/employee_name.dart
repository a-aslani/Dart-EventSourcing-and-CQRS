import 'package:ddd_dart/ddd/domain/exceptions/invalid_value_object_state_exception.dart';
import 'package:ddd_dart/ddd/domain/value_objects/base_value_object.dart';
import 'package:ddd_dart/ddd/message_patterns.dart';

const employeeNameIsRequiredErr = "{{0}} is required";

class EmployeeName extends BaseValueObject<String> {

  final String value;

  EmployeeName._({required this.value});

  factory EmployeeName(String name) {

    if(name.trim().isEmpty) {
      throw InvalidValueObjectStateException(message: MessagePatterns.isRequired("name"));
    }

    return EmployeeName._(value: name);
  }

  @override
  List<Object> getEqualityComponents() {
    return [value];
  }
}