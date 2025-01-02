import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/entities/notification.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/repositories/notifications_repository.dart';

class GetNotifications {
  final NotificationsRepository repository;

  GetNotifications(this.repository);

  Future<Either<Exception, List<NotificationEntity>>> call() {
    return repository.getNotifications();
  }
} 