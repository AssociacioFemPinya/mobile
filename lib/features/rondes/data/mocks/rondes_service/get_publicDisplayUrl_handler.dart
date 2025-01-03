import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

abstract class GetPublicDisplayUrlHandler {
  static void handle(
    RondesDioMockInterceptor mock,
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    PublicDisplayUrlEntity publicDisplayUrl = mock.publicDisplayUrl;

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

    // If query param contains user email but is unknown, return 404
    if (queryParams["email"] != "mail@mail.com" &&
        queryParams["email"] != "emptyUrl@mail.com" &&
        queryParams["email"] != "wrongUrl@mail.com") {
      response = Response(
        requestOptions: options,
        statusCode: 404,
      );
      handler.resolve(response);
      return;
    }

    // Create a response object
    if (queryParams["email"] == "emptyUrl@mail.com") {
      publicDisplayUrl = publicDisplayUrl.copyWith(publicUrl: '');
    } else if (queryParams["email"] == "wrongUrl@mail.com") {
      publicDisplayUrl = publicDisplayUrl.copyWith(publicUrl: 'wrong url');
    }

    // Create a response object
    response = Response(
      requestOptions: options,
      data: jsonEncode(publicDisplayUrl.toModel().toJson()),
      statusCode: 200,
    );

    // Complete the request with the mock response
    handler.resolve(response);
  }
}
