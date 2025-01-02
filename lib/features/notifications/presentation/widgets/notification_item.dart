import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/entities/notification.dart';
import 'package:fempinya3_flutter_app/features/notifications/presentation/bloc/notifications_bloc.dart';

class NotificationItem extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: notification.isRead 
            ? theme.colorScheme.surface
            : theme.colorScheme.primaryContainer.withOpacity(0.08),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.1),
          ),
        ),
      ),
      child: InkWell(
        onTap: notification.isRead ? null : () {
          context.read<NotificationsBloc>().add(
            MarkAsReadEvent(notification.id),
          );
        },
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                notification.message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatTimestamp(notification.createdAt),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
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