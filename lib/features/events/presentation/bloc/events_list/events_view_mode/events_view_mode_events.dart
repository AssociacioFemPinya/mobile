part of 'events_view_mode_bloc.dart';

abstract class EventsViewModeEvent {}

class EventsViewModeSet extends EventsViewModeEvent {
  final EventsViewModeEnum value;
  EventsViewModeSet(this.value);
}
