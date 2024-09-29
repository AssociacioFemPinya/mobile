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

class EventViewInitial extends EventViewState {
  EventViewInitial({required super.event});
}

class EventViewEventLoaded extends EventViewState {
  EventViewEventLoaded({required super.event});
}

class EventViewEventLoadFailure extends EventViewState {
  EventViewEventLoadFailure({required super.event});
}