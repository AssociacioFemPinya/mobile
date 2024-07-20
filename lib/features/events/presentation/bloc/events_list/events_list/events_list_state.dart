part of 'events_list_bloc.dart';

typedef DateEvents = Map<DateTime, List<EventEntity>>;

class EventsListState {
  final DateEvents events;

  EventsListState({required this.events});

  EventsListState copyWith({
    DateEvents? events,
  }) {
    return EventsListState(
      events: events ?? this.events,
    );
  }
}

class EventsListLoadSuccess extends EventsListState {
  EventsListLoadSuccess(Map<DateTime, List<EventEntity>> events)
      : super(events: events);
}

class EventsListLoadFailure extends EventsListState {
  final String error;

  EventsListLoadFailure(this.error) : super(events: {});
}
