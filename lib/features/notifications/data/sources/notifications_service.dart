import '../models/notification_model.dart';

abstract class NotificationsService {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(String notificationId);
}

class NotificationsServiceImpl implements NotificationsService {
  final String baseUrl;

  NotificationsServiceImpl({required this.baseUrl});

  @override
  Future<List<NotificationModel>> getNotifications() async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }
} 