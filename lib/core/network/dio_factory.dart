import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fempinya3_flutter_app/core/network/loading_interceptor.dart';
import 'package:fempinya3_flutter_app/features/events/data/mocks/events_service/events_service.dart';
import 'package:fempinya3_flutter_app/features/login/login.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/mocks/notifications_service.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

class DioFactory {
  static Dio? _dio;

  static Dio getInstance() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: 'https://api.dev.fempinya.cat',
        connectTimeout: Duration(milliseconds: 20000),
        receiveTimeout: Duration(milliseconds: 20000),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '12345',
        },
      );
      _dio = Dio(options);

      _dio!.interceptors.add(LogInterceptor(
        // request: true,
        // requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));

      // _dio!.interceptors.add(InterceptorsWrapper(
      //   onRequest: (options, handler) async {
      //     // Récupérer le token d'authentification
      //     final prefs = await SharedPreferences.getInstance();
      //     final token = prefs.getString('auth_token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ));

      // Add interceptors, set base options, etc.
      _dio!.interceptors.add(LoadingInterceptor());
      // _dio!.interceptors.add(RondesDioMockInterceptor());
      // _dio!.interceptors.add(EventsDioMockInterceptor());
      // _dio!.interceptors.add(UsersDioMockInterceptor());
      // _dio.interceptors.add(TokensDioMockInterceptor());
      _dio!.interceptors.add(NotificationsDioMockInterceptor());
    }

    return _dio!;
  }
}
