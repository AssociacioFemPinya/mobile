import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:fempinya3_flutter_app/features/notifications/service_locator.dart';

class UpdateReadStatus {
  final NotificationsRepository repository = sl<NotificationsRepository>();

  Future<Either> call({required String notificationId}) async {
    return await repository.updateReadStatus(notificationId);
  }
} 