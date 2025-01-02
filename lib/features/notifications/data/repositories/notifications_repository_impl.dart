import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/entities/notification.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/sources/notifications_service.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsService _service;

  NotificationsRepositoryImpl(this._service);

  @override
  Future<Either<Exception, List<NotificationEntity>>> getNotifications() async {
    try {
      final notifications = await _service.getNotifications();
      return Right(notifications.map((model) => NotificationEntity.fromModel(model)).toList());
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