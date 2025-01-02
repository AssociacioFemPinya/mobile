import 'package:dartz/dartz.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../sources/notifications_service.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsService _service;

  NotificationsRepositoryImpl(this._service);

  @override
  Future<Either<Exception, List<NotificationEntity>>> getNotifications() async {
    try {
      final notifications = await _service.getNotifications();
      return Right(notifications);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> markAsRead(String notificationId) async {
    try {
      await _service.markAsRead(notificationId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }
} 