import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/core/usecase/usecase.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:fempinya3_flutter_app/features/notifications/service_locator.dart';

class GetNotificationsParams {}

class GetNotifications implements UseCase<Either, GetNotificationsParams> {
  final NotificationsRepository repository = sl<NotificationsRepository>();

  @override
  Future<Either> call({required GetNotificationsParams params}) async {
    return await repository.getNotifications(params);
  }
}
