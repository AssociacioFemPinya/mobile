part of 'event_view_bloc.dart';

class EventViewState {
  final EventEntity? event;

  EventViewState({required this.event});

  EventViewState copyWith({
    EventEntity? event,
  }) {
    return EventViewState(
      event: event ?? this.event,
    );
  }
}
