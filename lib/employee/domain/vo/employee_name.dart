import 'package:ddd_dart/ddd/domain/exceptions/invalid_value_object_state_exception.dart';
import 'package:ddd_dart/ddd/domain/value_objects/base_value_object.dart';
import 'package:ddd_dart/employee/domain/error/error_codes.dart';

const employeeNameMinLen = 4;

class EmployeeName extends BaseValueObject<String> {

  final String value;

  EmployeeName._({required this.value});

  factory EmployeeName(String name) {

    if(name.trim().isEmpty) {
      throw InvalidValueObjectStateException(error: isRequiredErr.vars(params: ["name"]));
    }

    if(name.trim().length < employeeNameMinLen) {
      throw InvalidValueObjectStateException(error: minLenErr.vars(params: ["name", employeeNameMinLen, name.trim().length]));
    }

    return EmployeeName._(value: name);
  }

  @override
  List<Object> getEqualityComponents() {
    return [value];
  }
}