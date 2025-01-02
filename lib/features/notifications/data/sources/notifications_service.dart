import 'package:fempinya3_flutter_app/features/notifications/data/models/notification_model.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/mocks/notification_mock_handlers.dart';

abstract class NotificationsService {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(String notificationId);
}

class NotificationsServiceImpl implements NotificationsService {
  final String baseUrl;

  NotificationsServiceImpl({required this.baseUrl});

  @override
  Future<List<NotificationModel>> getNotifications() async {
    return NotificationMockHandlers.getNotifications();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    return NotificationMockHandlers.markAsRead(notificationId);
  }
} 