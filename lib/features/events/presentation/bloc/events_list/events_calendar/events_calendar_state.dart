import 'package:table_calendar/table_calendar.dart';

typedef DateEventsName = Map<DateTime, List<String>>;

class EventsCalendarState {
  final DateEventsName calendarEvents;
  final CalendarFormat calendarFormat;
  final DateTime focusedDay;
  final DateTime? selectedDay;

  EventsCalendarState(
      {required this.calendarEvents,
      required this.calendarFormat,
      required this.focusedDay,
      required this.selectedDay});

  EventsCalendarState copyWith({
    DateEventsName? calendarEvents,
    CalendarFormat? calendarFormat,
    DateTime? focusedDay,
    DateTime? selectedDay,
  }) {
    return EventsCalendarState(
      calendarEvents: calendarEvents ?? this.calendarEvents,
      calendarFormat: calendarFormat ?? this.calendarFormat,
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay,
    );
  }
}
