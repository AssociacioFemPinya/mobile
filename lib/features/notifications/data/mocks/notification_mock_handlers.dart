import 'package:fempinya3_flutter_app/features/notifications/data/models/notification_model.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/mocks/notification_mock.dart';

class NotificationMockHandlers {
  static Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(seconds: 1));
    return notificationsMock;
  }

  static Future<void> updateReadStatus(String notificationId) async {
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