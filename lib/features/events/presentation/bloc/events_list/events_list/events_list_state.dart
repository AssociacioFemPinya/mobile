part of 'events_list_bloc.dart';

typedef DateEvents = Map<DateTime, List<EventEntity>>;

class EventsListState {
  final DateEvents events;
  final EventsFiltersState eventsFiltersState;

  EventsListState({required this.events, required this.eventsFiltersState});

  EventsListState copyWith({
    DateEvents? events,
  }) {
    return EventsListState(
      events: events ?? this.events,
      eventsFiltersState: eventsFiltersState,
    );
  }
}
