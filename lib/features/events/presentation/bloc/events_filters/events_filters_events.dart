import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';

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

class EventsTypeFiltersAdd extends EventsFilterEvent {
  final EventTypeEnum value;
  EventsTypeFiltersAdd(this.value);
}

class EventsTypeFiltersRemove extends EventsFilterEvent {
  final EventTypeEnum value;
  EventsTypeFiltersRemove(this.value);
}
