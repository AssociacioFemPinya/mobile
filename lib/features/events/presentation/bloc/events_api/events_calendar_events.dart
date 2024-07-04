import 'package:table_calendar/table_calendar.dart';

class EventsCalendarEvent {}

class EventsCalendarDateSelected extends EventsCalendarEvent {
  final DateTime value;
  EventsCalendarDateSelected(this.value);
}

class EventsCalendarDateFocused extends EventsCalendarEvent {
  final DateTime value;
  EventsCalendarDateFocused(this.value);
}

class EventsCalendarFormatSet extends EventsCalendarEvent {
  final CalendarFormat value;
  EventsCalendarFormatSet(this.value);
}
