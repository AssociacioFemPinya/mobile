import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/core/network/dio_factory.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final sl = GetIt.instance;

Logger createLogger() {
  return Logger(
    level: Level.debug, // Cambia el nivel según sea necesario
    printer: PrettyPrinter(),
  );
}

Future<void> setupCommonServiceLocator() async {
  // Important: Keep dio instance on top, otherwise services (which use dio) will get a get_it not found error
  sl.registerLazySingleton<Dio>(() => DioFactory.getInstance());
  sl.registerLazySingleton<Logger>(() => createLogger());
  
  // Register GoRouter lazily - it will be initialized in main.dart
  //sl.registerLazySingleton<GoRouter>(() => throw UnimplementedError('GoRouter must be initialized in main.dart'));
}
