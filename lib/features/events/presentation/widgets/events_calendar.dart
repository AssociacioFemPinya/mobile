import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_calendar/events_calendar_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_calendar/events_calendar_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_calendar/events_calendar_state.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view/events_view_mode_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view/events_view_mode_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsCalendar extends StatelessWidget {
  const EventsCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsViewModeBloc, EventsViewModeState>(
      builder: (context, state) {
        return Visibility(
          visible: state.isEventInViewModeCalendar(),
          child: tableCalendar(context),
        );
      },
    );
  }

  BlocBuilder tableCalendar(BuildContext context) {
    return BlocBuilder<EventsCalendarBloc, EventsCalendarState>(
        builder: (context, state) {
      return TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: state.focusedDay,
        calendarFormat: state.calendarFormat,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
        ),
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(state.selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(state.selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            context.read<EventsCalendarBloc>().add(EventsCalendarDateSelected(selectedDay));
            context.read<EventsCalendarBloc>().add(EventsCalendarFormatSet(CalendarFormat.week));
          }
        },
        onHeaderTapped: (selectedDay) {
          context.read<EventsCalendarBloc>().add(EventsCalendarFormatSet(CalendarFormat.month));
        },
        // onPageChanged: (focusedDay) {
        //   // No need to call `setState()` here
        //   _focusedDay = focusedDay;
        // },
      );
    });
  }
}
