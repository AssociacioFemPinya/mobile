import '../models/notification_model.dart';
import 'notifications_service.dart';

class NotificationsServiceMock implements NotificationsService {
  @override
  Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      NotificationModel(
        id: '1',
        title: 'Nuevo evento',
        message: 'Se ha creado un nuevo evento para mañana',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NotificationModel(
        id: '2',
        title: 'Recordatorio',
        message: 'Tienes un evento pendiente de responder',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ];
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
} 