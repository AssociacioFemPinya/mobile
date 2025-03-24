part of 'notifications_bloc.dart';

abstract class NotificationsEvents extends Equatable {
  const NotificationsEvents();

  @override
  List<Object> get props => [];
}

class LoadNotifications extends NotificationsEvents {}

class UpdateReadStatusEvent extends NotificationsEvents {
  final String notificationId;

  const UpdateReadStatusEvent(this.notificationId);

  @override
  List<Object> get props => [notificationId];
} 