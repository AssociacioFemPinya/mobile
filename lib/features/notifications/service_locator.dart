import 'package:fempinya3_flutter_app/features/notifications/domain/useCases/get_notification.dart';
import 'package:get_it/get_it.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/sources/notifications_service.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/useCases/get_notifications.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/useCases/update_read_status.dart';

final sl = GetIt.instance;


Future<void> setupNotificationsServiceLocator() async {
  // Important: Keep dio instance on top, otherwise services (which use dio) will get a get_it not found error
  sl.registerSingleton<NotificationsService>(NotificationsServiceImpl());
  sl.registerSingleton<NotificationsRepository>(NotificationsRepositoryImpl());
  sl.registerSingleton<GetNotifications>(GetNotifications());
  sl.registerSingleton<UpdateReadStatus>(UpdateReadStatus());
  sl.registerSingleton<GetNotification>(GetNotification());
}