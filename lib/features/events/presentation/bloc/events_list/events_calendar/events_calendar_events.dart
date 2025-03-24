import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:table_calendar/table_calendar.dart';

abstract class EventsCalendarEvents {}

class EventsCalendarDateSelected extends EventsCalendarEvents {
  final DateTime value;
  EventsCalendarDateSelected(this.value);
}

class EventsCalendarDateSelectedUnset extends EventsCalendarEvents {
  EventsCalendarDateSelectedUnset();
}

class EventsCalendarDateFocused extends EventsCalendarEvents {
  final DateTime focusedDay;
  EventsCalendarDateFocused(this.focusedDay);
}

class EventsCalendarFormatSet extends EventsCalendarEvents {
  final CalendarFormat format;
  EventsCalendarFormatSet(this.format);
}

class LoadCalendarEvents extends EventsCalendarEvents {}

class CalendarEventsLoadSuccess extends EventsCalendarEvents {
  final List<EventEntity> value;
  CalendarEventsLoadSuccess(this.value);
}

class CalendarEventsLoadFailure extends EventsCalendarEvents {
  final String value;
  CalendarEventsLoadFailure(this.value);
}
