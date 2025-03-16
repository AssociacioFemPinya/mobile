import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/core/network/loading_interceptor.dart';
import 'package:fempinya3_flutter_app/features/events/data/mocks/events_service/events_service.dart';
import 'package:fempinya3_flutter_app/features/login/login.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/mocks/notifications_service.dart';

class DioFactory {
  static Dio? _dio;

  static Dio getInstance() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: 'https://556c-37-222-242-105.ngrok-free.app/api-fempinya',
        connectTimeout: Duration(milliseconds: 20000),
        receiveTimeout: Duration(milliseconds: 20000),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer suOrs6kIjDLaGr7d09rnA7NuZ45hht5J5DqSCkdQ9a923540',
          'ngrok-skip-browser-warning': '12345',
        },
      );
      _dio = Dio(options);

      _dio!.interceptors.add(LogInterceptor(
        // request: true,
        // requestHeader: true,
        // requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));
      // Add interceptors, set base options, etc.
      _dio!.interceptors.add(LoadingInterceptor());
      _dio!.interceptors.add(RondesDioMockInterceptor());
      //_dio!.interceptors.add(EventsDioMockInterceptor());
      _dio!.interceptors.add(UsersDioMockInterceptor());
      _dio!.interceptors.add(NotificationsDioMockInterceptor());
    }

    return _dio!;
  }
}
