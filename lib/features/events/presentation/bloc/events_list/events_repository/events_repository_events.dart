part of 'events_repository_bloc.dart';

class EventsRepositoryEvent {}

class EventsListLoaded extends EventsRepositoryEvent {
  final List<EventEntity> value;
  EventsListLoaded(this.value);
}

class LoadEventsList extends EventsRepositoryEvent {}

