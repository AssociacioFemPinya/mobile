import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/models/notification_model.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/entities/notification.dart';
import 'package:fempinya3_flutter_app/features/notifications/service_locator.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/useCases/get_notifications.dart';
abstract class NotificationsService {
  Future<Either<String, List<NotificationEntity>>> getNotifications(GetNotificationsParams params);
  Future<Either<String, void>> updateReadStatus(String notificationId);
}

class NotificationsServiceImpl implements NotificationsService {
  final Dio _dio = sl<Dio>();
  final Logger _logger = sl<Logger>();

  @override
  Future<Either<String, List<NotificationEntity>>> getNotifications(GetNotificationsParams params) async {
    try {
      final response = await _dio.get('/notifications');
      if (response.statusCode == 200 && response.data is String) {
        final jsonList = jsonDecode(response.data as String) as List<dynamic>;
        final notifications = jsonList
            .map((json) => NotificationEntity.fromModel(NotificationModel.fromJson(json)))
            .toList();
        return Right(notifications);
      }
      return const Left('Unexpected response format');
    } catch (e, stacktrace) {
      _logError('Error when calling /notifications endpoint', e, stacktrace);
      return Left('Error when calling /notifications endpoint: $e');
    }
  }

  @override
  Future<Either<String, void>> updateReadStatus(String notificationId) async {
    try {
      final response = await _dio.patch(
        '/notifications/$notificationId/read',
      );
      if (response.statusCode == 200) {
        return const Right(null);
      }
      return const Left('Failed to update notification status');
    } catch (e, stacktrace) {
      _logError('Error when updating notification status', e, stacktrace);
      return Left('Error when updating notification status: $e');
    }
  }

  void _logError(String message, dynamic error, StackTrace stacktrace) {
    _logger.e(message, error, stacktrace);
  }
} 