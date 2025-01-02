import 'package:dartz/dartz.dart';
import '../entities/notification.dart';

abstract class NotificationsRepository {
  Future<Either<Exception, List<NotificationEntity>>> getNotifications();
  Future<Either<Exception, void>> markAsRead(String notificationId);
} 