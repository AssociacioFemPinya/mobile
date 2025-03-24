import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/mocks/notification_mock.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/mocks/notifications_service.dart';

class GetNotificationHandler {
  static void handle(
    NotificationsDioMockInterceptor mock,
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    //final queryParams = options.queryParameters;
    Response<dynamic> response;
    print(">>>>GetNotificationHandler");
    final pathSegments = options.path.split('/');
    final lastSegment = pathSegments.isNotEmpty ? pathSegments.last : '';

    //todo zan
    /* 
    // If query param doesn't contain notificationID, return none
    if (!queryParams.containsKey("id")) {
      response = Response(
        requestOptions: options,
        statusCode: 500,
      );
      handler.resolve(response);
      return;
    }*/

    //int notificationID = queryParams["id"];

    for (var notification in notificationsMock) {
      if (notification.id == lastSegment) {
        response = Response(
          requestOptions: options,
          data: notification.toJson(),
          statusCode: 200,
        );
        handler.resolve(response);
        return;
      }
    }

    response = Response(
      requestOptions: options,
      statusCode: 500,
    );
    handler.resolve(response);
  }
}
