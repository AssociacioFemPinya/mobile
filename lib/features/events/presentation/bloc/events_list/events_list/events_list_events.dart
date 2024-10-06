part of 'events_list_bloc.dart';

abstract class EventsListEvent {}

class LoadEventsList extends EventsListEvent {
  final EventsFiltersState value;
  LoadEventsList(this.value);
}

class EventsListLoadSuccess extends EventsListEvent {
  final List<EventEntity> value;
  EventsListLoadSuccess(this.value);
}

class EventsListLoadFailure extends EventsListEvent {
  final String value;
  EventsListLoadFailure(this.value);
}
