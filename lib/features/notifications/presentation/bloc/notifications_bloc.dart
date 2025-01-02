import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/notification.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/mark_notification_as_read.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final getNotifications = GetIt.instance<GetNotifications>();
  final markAsRead = GetIt.instance<MarkNotificationAsRead>();

  NotificationsBloc() : super(NotificationsInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<MarkAsReadEvent>(_onMarkNotificationAsRead);
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(NotificationsLoading());
    try {
      final result = await getNotifications();
      result.fold(
        (failure) {
          emit(NotificationsError(failure.toString()));
        },
        (notifications) {
          emit(NotificationsLoaded(notifications));
        },
      );
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }

  Future<void> _onMarkNotificationAsRead(
    MarkAsReadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    final result = await markAsRead(event.notificationId);
    result.fold(
      (failure) => emit(NotificationsError(failure.toString())),
      (_) => add(LoadNotifications()), 
    );
  }
} 