import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/notification.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<MarkNotificationAsRead>(_onMarkNotificationAsRead);
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(NotificationsLoading());
    try {
      // TODO: Implement loading notifications from repository
      final notifications = <NotificationEntity>[];
      emit(NotificationsLoaded(notifications));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }

  Future<void> _onMarkNotificationAsRead(
    MarkNotificationAsRead event,
    Emitter<NotificationsState> emit,
  ) async {
    // TODO: Implement marking notification as read
  }
} 