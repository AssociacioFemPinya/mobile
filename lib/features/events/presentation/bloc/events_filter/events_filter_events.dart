enum EventsStatusFilters {
  missingReply,
  replied,
  requiresAttention,
}

class EventsFilterEvent {}

class EventsStatusFilterUndefined extends EventsFilterEvent {
  final bool value;
  EventsStatusFilterUndefined(this.value);
}

class EventsStatusFilterAnswered extends EventsFilterEvent {
  final bool value;
  EventsStatusFilterAnswered(this.value);
}

class EventsStatusFilterWarning extends EventsFilterEvent {
  final bool value;
  EventsStatusFilterWarning(this.value);
}
