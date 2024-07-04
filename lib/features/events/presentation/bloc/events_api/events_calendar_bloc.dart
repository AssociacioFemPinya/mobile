import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_calendar/events_calendar_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_calendar/events_calendar_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsCalendarBloc
    extends Bloc<EventsCalendarEvent, EventsCalendarState> {
  EventsCalendarBloc()
      : super(EventsCalendarState(
          calendarFormat: CalendarFormat.month,
          focusedDay: DateTime.now(),
          selectedDay: null,
        )) {
    on<EventsCalendarDateSelected>((event, emit) {
      emit(state.copyWith(selectedDay: event.value));
    });
    on<EventsCalendarDateFocused>((event, emit) {
      emit(state.copyWith(focusedDay: event.value));
    });
    on<EventsCalendarFormatSet>((event, emit) {
      emit(state.copyWith(calendarFormat: event.value));
    });
  }
}
