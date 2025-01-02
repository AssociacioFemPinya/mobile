import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/notification.dart';
import '../bloc/notifications_bloc.dart';

class NotificationItem extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        notification.title,
        style: TextStyle(
          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Text(notification.message),
      trailing: notification.isRead 
          ? null 
          : IconButton(
              icon: const Icon(Icons.circle, size: 12),
              onPressed: () {
                context.read<NotificationsBloc>().add(
                  MarkAsReadEvent(notification.id),
                );
              },
            ),
    );
  }
} 