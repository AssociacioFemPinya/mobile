import 'package:equatable/equatable.dart';
import 'package:fempinya3_flutter_app/features/notifications/data/models/notification_model.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String body;
  final DateTime date;
  final bool isRead;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [id, title, body, date, isRead];

  factory NotificationEntity.fromModel(NotificationModel model) {
    return NotificationEntity(
      id: model.id,
      title: model.title,
      body: model.body,
      date: model.date,
      isRead: model.isRead,
    );
  }

  NotificationModel toModel() {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      date: date,
      isRead: isRead,
    );
  }
} 