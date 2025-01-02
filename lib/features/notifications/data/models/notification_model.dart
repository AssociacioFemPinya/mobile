import '../../domain/entities/notification.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required String id,
    required String title,
    required String message,
    required DateTime createdAt,
    bool isRead = false,
  }) : super(
          id: id,
          title: title,
          message: message,
          createdAt: createdAt,
          isRead: isRead,
        );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'message': message,
        'createdAt': createdAt.toIso8601String(),
        'isRead': isRead,
      };
} 