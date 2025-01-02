import 'package:dartz/dartz.dart';
import '../repositories/notifications_repository.dart';

class MarkNotificationAsRead {
  final NotificationsRepository repository;

  MarkNotificationAsRead(this.repository);

  Future<Either<Exception, void>> call(String notificationId) {
    return repository.markAsRead(notificationId);
  }
} 