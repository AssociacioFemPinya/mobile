import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsCalendarEvent {}

class EventsCalendarDateSelected extends EventsCalendarEvent {
  final DateTime value;
  EventsCalendarDateSelected(this.value);
}

class EventsCalendarDateSelectedUnset extends EventsCalendarEvent {
  EventsCalendarDateSelectedUnset();
}

class EventsCalendarDateFocused extends EventsCalendarEvent {
  final DateTime value;
  EventsCalendarDateFocused(this.value);
}

class EventsCalendarFormatSet extends EventsCalendarEvent {
  final CalendarFormat value;
  EventsCalendarFormatSet(this.value);
}

class LoadCalendarEvents extends EventsCalendarEvent {}

class CalendarEventsLoaded extends EventsCalendarEvent {
    final List<EventEntity> value;
    CalendarEventsLoaded(this.value);
}

class CalendarEventsLoadFailure extends EventsCalendarEvent {
    final String value;
    CalendarEventsLoadFailure(this.value);
}