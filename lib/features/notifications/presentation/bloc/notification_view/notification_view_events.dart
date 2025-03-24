part of 'notification_view_bloc.dart';

abstract class NotificationViewEvents {}

class LoadNotification extends NotificationViewEvents{
  final int value;
  LoadNotification(this.value);
}

class NotificationLoadSuccess extends NotificationViewEvents{
  final NotificationEntity value;
  NotificationLoadSuccess(this.value);
}

class NotificationLoadFailure extends NotificationViewEvents{
  final String value;
  NotificationLoadFailure(this.value);
}

