part of 'events_list_bloc.dart';

class EventsListEvent {}

class EventsListLoaded extends EventsListEvent {
  final List<EventEntity> value;
  EventsListLoaded(this.value);
}

class LoadEventsList extends EventsListEvent {}

