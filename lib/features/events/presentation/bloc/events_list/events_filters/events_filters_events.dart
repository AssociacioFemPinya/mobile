part of 'events_filters_bloc.dart';

enum EventsStatusFilters {
  missingReply,
  replied,
  requiresAttention,
}

abstract class EventsFiltersEvents {}

class EventsStatusFilterUndefined extends EventsFiltersEvents {
  final bool value;
  EventsStatusFilterUndefined(this.value);
}

class EventsStatusFilterAnswered extends EventsFiltersEvents {
  final bool value;
  EventsStatusFilterAnswered(this.value);
}

class EventsStatusFilterWarning extends EventsFiltersEvents {
  final bool value;
  EventsStatusFilterWarning(this.value);
}

class EventsTypeFiltersAdd extends EventsFiltersEvents {
  final EventTypeEnum value;
  EventsTypeFiltersAdd(this.value);
}

class EventsTypeFiltersRemove extends EventsFiltersEvents {
  final EventTypeEnum value;
  EventsTypeFiltersRemove(this.value);
}

class EventsDayFilterSet extends EventsFiltersEvents {
  final DateTime value;
  EventsDayFilterSet(this.value);
}

class EventsDayFilterUnset extends EventsFiltersEvents {
  EventsDayFilterUnset();
}
