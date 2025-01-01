import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

abstract class GetRondesListHandler {
  static void handle(
    RondesDioMockInterceptor mock,
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final List<RondaEntity> rondes = mock.rondesList;

    final queryParams = options.queryParameters;
    Response<dynamic> response;

    // If query param doesn't contain user email, return none
    if (!queryParams.containsKey("email") || queryParams["email"] == null) {
      response = Response(
        requestOptions: options,
        statusCode: 400,
      );
      handler.resolve(response);
      return;
    }

    // Create a response object
    response = Response(
      requestOptions: options,
      data:
          jsonEncode(rondes.map((ronda) => ronda.toModel().toJson()).toList()),
      statusCode: 200,
    );

    // Complete the request with the mock response
    handler.resolve(response);
  }
}
