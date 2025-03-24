part of 'events_list_bloc.dart';

abstract class EventsListEvents {}

class LoadEventsList extends EventsListEvents {
  final EventsFiltersState value;
  LoadEventsList(this.value);
}

class EventsListLoadSuccess extends EventsListEvents {
  final List<EventEntity> value;
  EventsListLoadSuccess(this.value);
}

class EventsListLoadFailure extends EventsListEvents {
  final String value;
  EventsListLoadFailure(this.value);
}
