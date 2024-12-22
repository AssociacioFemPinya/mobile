import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/core/network/loading_interceptor.dart';
import 'package:fempinya3_flutter_app/features/events/data/mocks/events_service/events_service.dart';
import 'package:fempinya3_flutter_app/features/login/login.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

class DioFactory {
  static Dio? _dio;

  static Dio getInstance() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: 'https://api.fempinya.cat',
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );
      _dio = Dio(options);

      // Add interceptors, set base options, etc.
      // _dio!.interceptors.add(LoadingInterceptor());
      _dio!.interceptors.add(RondesDioMockInterceptor());
      _dio!.interceptors.add(EventsDioMockInterceptor());
      _dio!.interceptors.add(UsersDioMockInterceptor());
    }

    return _dio!;
  }
}
