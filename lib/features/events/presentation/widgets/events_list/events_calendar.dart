import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_calendar/events_calendar_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_calendar/events_calendar_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_calendar/events_calendar_state.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_filters/events_filters_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_list/events_list_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_view_mode/events_view_mode_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

typedef EventLoader = List<String> Function(DateTime day);

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
            context
                .read<EventsCalendarBloc>()
                .add(EventsCalendarDateSelected(selectedDay));
            context
                .read<EventsCalendarBloc>()
                .add(EventsCalendarDateFocused(focusedDay));
            context
                .read<EventsCalendarBloc>()
                .add(EventsCalendarFormatSet(CalendarFormat.week));
            context
                .read<EventsFiltersBloc>()
                .add(EventsDayFilterSet(selectedDay));
          }
        },
        onHeaderTapped: (selectedDay) {
          context
              .read<EventsCalendarBloc>()
              .add(EventsCalendarFormatSet(CalendarFormat.month));
        },

        eventLoader: _createEventLoader(context),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              return Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              );
            }
            return SizedBox();
          },
        ),

        // onPageChanged: (focusedDay) {
        //   context
        //         .read<EventsCalendarBloc>()
        //         .add(EventsCalendarDateFocused(focusedDay));
        // },
      );
    });
  }

  EventLoader _createEventLoader(BuildContext context) {
    return (DateTime day) {
      List<EventEntity>? events =
          context.read<EventsListBloc>().state.events[day];
      return events != null ? [for (var event in events) event.title] : [];
    };
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
