import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

abstract class GetRondaHandler {
  static void handle(
    RondesDioMockInterceptor mock,
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final queryParams = options.queryParameters;
    Response<dynamic> response;

    // If query param doesn't contain eventID, return none
    if (!queryParams.containsKey("id") || queryParams["id"] == null) {
      response = Response(
        requestOptions: options,
        statusCode: 400,
      );
      handler.resolve(response);
      return;
    }

    // Try to find the event that match eventID
    int rondaID = queryParams["id"];
    for (var ronda in mock.rondesList) {
      if (ronda.id == rondaID) {
        response = Response(
          requestOptions: options,
          data: jsonEncode(ronda.toModel().toJson()),
          statusCode: 200,
        );
        handler.resolve(response);
        return;
      }
    }

    // Coudn't find the ronda so return not-found
    response = Response(
      requestOptions: options,
      statusCode: 404,
    );
    handler.resolve(response);
  }
}
