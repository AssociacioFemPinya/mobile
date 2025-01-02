import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String message;
  final DateTime createdAt;
  final bool isRead;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [id, title, message, createdAt, isRead];
} 