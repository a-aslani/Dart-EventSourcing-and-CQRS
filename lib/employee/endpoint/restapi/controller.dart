import 'dart:convert';

import 'package:ddd_dart/ddd/payload/response.dart';
import 'package:ddd_dart/ddd/util/id.dart';
import 'package:ddd_dart/employee/application_service/command/create_employee.dart';
import 'package:ddd_dart/employee/application_service/command/edit_employee_name.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Controller {
  final CreateEmployee createEmployee;
  final EditEmployeeName editEmployeeName;

  Controller({
    required this.createEmployee,
    required this.editEmployeeName,
  });

  Router router() {
    return Router()
      ..post('/employee', _createEmployeeHandler)
      ..put('/employee/<id>', _updateEmployeeNameHandler);
  }

  Future<Response> _createEmployeeHandler(Request req) async {
    final body = jsonDecode(await req.readAsString());

    final (employee, err) = await createEmployee(
      CreateEmployeeCommand(name: body["name"] ?? ""),
    );

    if (err != null) {
      return Response.badRequest(body: jsonEncode({"error": err.message}));
    }

    return Response.ok(
      jsonEncode({
        "id": employee!.id.toString(),
        "name": employee.name!.value,
      }),
    );
  }

  Future<Response> _updateEmployeeNameHandler(Request req) async {
    final traceID = generateID(16);

    final id = req.params['id'];
    final body = jsonDecode(await req.readAsString());

    final err = await editEmployeeName(
      EditEmployeeNameCommand(id: id!, name: body["name"] ?? ""),
    );

    if (err != null) {
      return Response.badRequest(
        body: ErrorResponse(
          errorMessage: err.message,
          traceID: traceID,
          errorCode: err.code,
        ).json(),
      );
    }

    return Response.ok(
      jsonEncode({
        "message": "successfully",
      }),
    );
  }
}
