import 'package:table_calendar/table_calendar.dart';

class EventsCalendarState {
  final CalendarFormat calendarFormat;
  final DateTime focusedDay;
  final DateTime? selectedDay;

  EventsCalendarState(
      {required this.calendarFormat,
      required this.focusedDay,
      required this.selectedDay});

  EventsCalendarState copyWith({
    CalendarFormat? calendarFormat,
    DateTime? focusedDay,
    DateTime? selectedDay,
  }) {
    return EventsCalendarState(
      calendarFormat: calendarFormat ?? this.calendarFormat,
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}
