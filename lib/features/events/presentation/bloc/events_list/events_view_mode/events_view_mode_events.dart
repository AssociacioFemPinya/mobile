part of 'events_view_mode_bloc.dart';

abstract class EventsViewModeEvents {}

class EventsViewModeSet extends EventsViewModeEvents {
  final EventsViewModeEnum value;
  EventsViewModeSet(this.value);
}
