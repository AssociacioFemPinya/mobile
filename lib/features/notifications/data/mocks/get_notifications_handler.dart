import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/mocks/notification_mock.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/mocks/notifications_service.dart';

class GetNotificationsHandler {
  static void handle(
    NotificationsDioMockInterceptor mock,
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {

    print(">>>>GetNotificationsHandler");
    handler.resolve(Response(
      requestOptions: options,
      statusCode: 200,
      data: jsonEncode(notificationsMock.map((n) => n.toJson()).toList()),
    ));
  }
} 