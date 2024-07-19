part of 'events_repository_bloc.dart';

typedef DateEvents = Map<DateTime, List<EventEntity>>;

class EventsRepositoryState {
  final DateEvents events;

  EventsRepositoryState({required this.events});

  EventsRepositoryState copyWith({
    DateEvents? events,
  }) {
    return EventsRepositoryState(
      events: events ?? this.events,
    );
  }
}

class EventsListLoadSuccess extends EventsRepositoryState {
  EventsListLoadSuccess(Map<DateTime, List<EventEntity>> events)
      : super(events: events);
}

class EventsListLoadFailure extends EventsRepositoryState {
  final String error;

  EventsListLoadFailure(this.error) : super(events: {});
}
