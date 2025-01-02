import 'package:dartz/dartz.dart';
import '../entities/notification.dart';
import '../repositories/notifications_repository.dart';

class GetNotifications {
  final NotificationsRepository repository;

  GetNotifications(this.repository);

  Future<Either<Exception, List<NotificationEntity>>> call() {
    return repository.getNotifications();
  }
} 