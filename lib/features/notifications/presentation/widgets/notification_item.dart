import 'package:flutter/material.dart';
import '../../domain/entities/notification.dart';

class NotificationItem extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(notification.title),
      subtitle: Text(notification.message),
      trailing: !notification.isRead ? const Icon(Icons.circle, size: 12) : null,
    );
  }
} 