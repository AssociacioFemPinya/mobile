import 'package:get_it/get_it.dart';
import 'data/repositories/notifications_repository_impl.dart';
import 'data/sources/notifications_service.dart';
import 'data/sources/notifications_service_mock.dart';
import 'domain/repositories/notifications_repository.dart';
import 'domain/usecases/get_notifications.dart';
import 'domain/usecases/mark_notification_as_read.dart';

void setupNotificationsServiceLocator() {
  final sl = GetIt.instance;

  // Use cases
  sl.registerLazySingleton(() => GetNotifications(sl()));
  sl.registerLazySingleton(() => MarkNotificationAsRead(sl()));

  // Repository
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<NotificationsService>(
    () => NotificationsServiceMock(),
  );
} 