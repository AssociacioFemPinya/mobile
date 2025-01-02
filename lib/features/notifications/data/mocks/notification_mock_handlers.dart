import '../models/notification_model.dart';
import 'notification_mock.dart';

class NotificationMockHandlers {
  static Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(seconds: 1));
    return notificationsMock;
  }

  static Future<void> markAsRead(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = notificationsMock.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      final oldNotification = notificationsMock[index];
      notificationsMock[index] = NotificationModel(
        id: oldNotification.id,
        title: oldNotification.title,
        message: oldNotification.message,
        createdAt: oldNotification.createdAt,
        isRead: true,
      );
    }
  }
} 