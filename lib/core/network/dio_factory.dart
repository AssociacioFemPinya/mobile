import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/features/events/data/sources/events_service_dio_mockup.dart';

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
      _dio!.interceptors.add(EventsDioMockInterceptor());
    }

    return _dio!;
  }
}
