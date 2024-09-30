part of 'event_view_bloc.dart';

abstract class EventViewEvent {}

class LoadEvent extends EventViewEvent {
  final int value;
  LoadEvent(this.value);
}

class EventLoadSuccess extends EventViewEvent {
  final EventEntity value;
  EventLoadSuccess(this.value);
}

class EventLoadFailure extends EventViewEvent {
  final String value;
  EventLoadFailure(this.value);
}

class EventStatusModified extends EventViewEvent {
  final EventStatusEnum value;
  EventStatusModified(this.value);
}

class UpdateEvent extends EventViewEvent {
  UpdateEvent();
}

class UpdateEventSuccess extends EventViewEvent {
  UpdateEventSuccess();
}

class UpdateEventFailure extends EventViewEvent {
  UpdateEventFailure();
}
