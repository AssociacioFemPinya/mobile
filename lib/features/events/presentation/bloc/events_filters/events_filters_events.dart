import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';

enum EventsStatusFilters {
  missingReply,
  replied,
  requiresAttention,
}

class EventsFiltersEvent {}

class EventsStatusFilterUndefined extends EventsFiltersEvent {
  final bool value;
  EventsStatusFilterUndefined(this.value);
}

class EventsStatusFilterAnswered extends EventsFiltersEvent {
  final bool value;
  EventsStatusFilterAnswered(this.value);
}

class EventsStatusFilterWarning extends EventsFiltersEvent {
  final bool value;
  EventsStatusFilterWarning(this.value);
}

class EventsTypeFiltersAdd extends EventsFiltersEvent {
  final EventTypeEnum value;
  EventsTypeFiltersAdd(this.value);
}

class EventsTypeFiltersRemove extends EventsFiltersEvent {
  final EventTypeEnum value;
  EventsTypeFiltersRemove(this.value);
}
