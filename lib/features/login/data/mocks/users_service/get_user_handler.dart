import 'package:fempinya3_flutter_app/features/login/login.dart';

import 'dart:convert';
import 'package:dio/dio.dart';

abstract class GetUserHandler {
  static void handle(
    UsersDioMockInterceptor mock,
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final queryParams = options.queryParameters;
    Response<dynamic> response;

    // If query param doesn't contain mail, return none
    if (!queryParams.containsKey("mail")) {
      response = Response(
        requestOptions: options,
        statusCode: 500,
      );
      handler.resolve(response);
      return;
    }

    // If query param doesn't contain password, return none
    if (!queryParams.containsKey("password")) {
      response = Response(
        requestOptions: options,
        statusCode: 500,
      );
      handler.resolve(response);
      return;
    }

    // Try to find the User that match mail and password
    String userMail = queryParams["mail"];
    String userPassword = queryParams["password"];
    for (var User in mock.UserList) {
      if (User.mail == userMail && User.password == userPassword) {
        response = Response(
          requestOptions: options,
          data: jsonEncode(User.toModel().toJson()),
          statusCode: 200,
        );
        handler.resolve(response);
        return;
      }
    }

    // Coudn't find the User so return not-found
    response = Response(
      requestOptions: options,
      statusCode: 500,
    );
    handler.resolve(response);
  }
}
