enum StatusFilters {
  missingReply,
  replied,
  requiresAttention,
}

class StatusFilterEvent {}

class StatusUndefined extends StatusFilterEvent {
  final bool value;
  StatusUndefined(this.value);
}

class StatusAnswered extends StatusFilterEvent {
  final bool value;
  StatusAnswered(this.value);
}

class StatusWarning extends StatusFilterEvent {
  final bool value;
  StatusWarning(this.value);
}
