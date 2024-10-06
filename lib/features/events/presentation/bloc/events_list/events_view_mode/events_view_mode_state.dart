part of 'events_view_mode_bloc.dart';

class EventsViewModeState {
  final EventsViewModeEnum eventsViewMode;

  EventsViewModeState(
      {required this.eventsViewMode});

  EventsViewModeState copyWith({
    EventsViewModeEnum? eventsViewMode,
  }) {
    return EventsViewModeState(
        eventsViewMode: eventsViewMode ?? this.eventsViewMode,
    );
  }

  bool isEventInViewModeCalendar() {
    return eventsViewMode == EventsViewModeEnum.calendar;
  }

  bool isEventInViewModeList() {
    return eventsViewMode == EventsViewModeEnum.list;
  }
}
