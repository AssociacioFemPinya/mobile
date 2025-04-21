import 'package:dio/dio.dart';

import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

abstract class GetPublicDisplayUrlHandler {
  static void handle(
    RondesDioMockInterceptor mock,
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    Map<String, dynamic> publicDisplayUrl = mock.publicDisplayUrl;

    Response<dynamic> response;

    // Create a response object
    response = Response(
      requestOptions: options,
      data: publicDisplayUrl,
      statusCode: 200,
    );

    // Complete the request with the mock response
    handler.resolve(response);
    return;
  }
}
