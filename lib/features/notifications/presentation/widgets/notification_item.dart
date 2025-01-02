import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/notification.dart';
import '../bloc/notifications_bloc.dart';

class NotificationItem extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: notification.isRead 
          ? theme.colorScheme.surface
          : theme.colorScheme.primaryContainer.withOpacity(0.1),
      elevation: notification.isRead ? 0 : 1,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: notification.isRead 
              ? theme.colorScheme.surfaceVariant
              : theme.colorScheme.primaryContainer,
          child: Icon(
            notification.isRead 
                ? Icons.notifications_outlined
                : Icons.notifications_active,
            color: notification.isRead 
                ? theme.colorScheme.onSurfaceVariant
                : theme.colorScheme.primary,
            size: 20,
          ),
        ),
        title: Text(
          notification.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
            color: notification.isRead 
                ? theme.colorScheme.onSurfaceVariant
                : theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: notification.isRead 
                    ? theme.colorScheme.onSurfaceVariant.withOpacity(0.8)
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTimestamp(notification.createdAt),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
              ),
            ),
          ],
        ),
        onTap: notification.isRead ? null : () {
          context.read<NotificationsBloc>().add(
            MarkAsReadEvent(notification.id),
          );
        },
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'hace unos segundos';
    } else if (difference.inHours < 1) {
      return 'hace ${difference.inMinutes} minutos';
    } else if (difference.inDays < 1) {
      return 'hace ${difference.inHours} horas';
    } else {
      return 'hace ${difference.inDays} días';
    }
  }
} 