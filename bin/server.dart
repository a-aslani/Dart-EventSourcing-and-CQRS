import 'dart:io';
import 'package:ddd_dart/employee/application_service/command/create_employee.dart';
import 'package:ddd_dart/employee/application_service/command/edit_employee_name.dart';
import 'package:ddd_dart/employee/endpoint/restapi/controller.dart';
import 'package:ddd_dart/employee/infrastructure/repository/postgres_employee_command_repository.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

void main(List<String> args) async {
  final conn = await Connection.open(
    Endpoint(
      host: 'localhost',
      database: 'dart_eda',
      username: 'root',
      password: 'YOUR_PASSWORD',
      port: 5432,
    ),
    settings: ConnectionSettings(sslMode: SslMode.disable),
  );

  final repository = PostgresEmployeeCommandRepository(conn);

  final controller = Controller(
    createEmployee: CreateEmployee(repository: repository),
    editEmployeeName: EditEmployeeName(repository: repository),
  );

  swagger();

  final ip = InternetAddress.anyIPv4;
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(controller.router().call);
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}

void swagger() async {
  final path = 'specs/swagger.yaml';
  final handler = SwaggerUI(path, title: 'Swagger Test');
  var server = await serve(handler.call, '0.0.0.0', 4001);
  print('Serving at http://localhost:${server.port}');
}
