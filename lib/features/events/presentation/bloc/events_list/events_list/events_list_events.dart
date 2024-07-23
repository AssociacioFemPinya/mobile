part of 'events_list_bloc.dart';

class EventsListEvent {}

class LoadEventsList extends EventsListEvent {}

class EventsListLoadSuccess extends EventsListEvent {
  final List<EventEntity> value;
  EventsListLoadSuccess(this.value);
}

class EventsListLoadFailure extends EventsListEvent {
    final String value;
    EventsListLoadFailure(this.value);
}
