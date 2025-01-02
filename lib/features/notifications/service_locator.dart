import 'package:get_it/get_it.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/sources/notifications_service.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/sources/notifications_service_mock.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/useCases/get_notifications.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/useCases/mark_notification_as_read.dart';

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