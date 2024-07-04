import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_view_mode.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_calendar/events_calendar_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_calendar/events_calendar_state.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filters/events_filters_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filters/events_filters_state.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_repository/events_repository_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_repository/events_repository_state.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view_mode/events_view_mode_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view_mode/events_view_mode_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsListWidget extends StatelessWidget {
  const EventsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsFiltersBloc, EventsFiltersState>(
        builder: (context, eventsFiltersState) {
      return BlocBuilder<EventsCalendarBloc, EventsCalendarState>(
        builder: (context, eventsCalendarState) {
          return BlocBuilder<EventsRepositoryBloc, EventsRepositoryState>(
            builder: (context, eventsRepositoryState) {
              return BlocBuilder<EventsViewModeBloc, EventsViewModeState>(
                builder: (context, eventsViewModeState) {
                  final filteredEvents = filterEvents(
                    eventsRepositoryState.events,
                    eventsViewModeState.eventsViewMode,
                    eventsFiltersState.eventTypeFilters,
                    eventsCalendarState.selectedDay,
                    eventsFiltersState.showAnswered,
                    eventsFiltersState.showUndefined,
                    eventsFiltersState.showWarning,
                  );

                  return ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final date = filteredEvents[index];
                      return _buildDateEventsList(date, context);
                    },
                  );
                },
              );
            },
          );
        },
      );
    });
  }

  Widget _buildDateEventsList(DateMockup date, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            date.date,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Column(
          children: date.events.map((event) => _buildEventCard(event)).toList(),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildEventCard(EventMockup event) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(event.status),
          child: Icon(_getStatusIcon(event.status), color: Colors.white),
        ),
        title: Text(event.name),
        subtitle: Text('${event.address} - ${event.dateHour}'),
        trailing: Icon(event.icon),
      ),
    );
  }

  IconData _getStatusIcon(EventStatusEnum status) {
    switch (status) {
      case EventStatusEnum.accepted:
        return Icons.check;
      case EventStatusEnum.declined:
        return Icons.close;
      case EventStatusEnum.unknown:
        return Icons.help_outline;
      case EventStatusEnum.undefined:
        return Icons.remove;
      case EventStatusEnum.warning:
        return Icons.warning;
      default:
        return Icons.help_outline;
    }
  }

  Color _getStatusColor(EventStatusEnum status) {
    switch (status) {
      case EventStatusEnum.accepted:
        return Colors.green;
      case EventStatusEnum.declined:
        return Colors.red;
      case EventStatusEnum.unknown:
        return Colors.orange;
      case EventStatusEnum.undefined:
        return Colors.grey;
      case EventStatusEnum.warning:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  List<DateMockup> filterEvents(
    List<DateMockup> dateEvents,
    EventsViewModeEnum eventsViewMode,
    List<EventTypeEnum> eventTypeFilters,
    DateTime? calendarDate,
    bool showAnswered,
    bool showUndefined,
    bool showWarning,
  ) {
    List<DateMockup> events = calendarDate != null && eventsViewMode == EventsViewModeEnum.calendar
        ? getEventsByDate(calendarDate, dateEvents)
        : dateEvents;
    List<DateMockup> filteredEventsByType =
        filterByType(events, eventTypeFilters);
    return filterByStatus(
      filteredEventsByType,
      showAnswered,
      showUndefined,
      showWarning,
    );
  }

  List<DateMockup> filterByType(
    List<DateMockup> dateEvents,
    List<EventTypeEnum> eventTypeFilters,
  ) {
    if (eventTypeFilters.isEmpty) {
      return dateEvents;
    }

    List<DateMockup> filteredDateEvents = [];

    for (var date in dateEvents) {
      List<EventMockup> filteredEvents = date.events.where((event) {
        return eventTypeFilters.contains(event.type);
      }).toList();

      if (filteredEvents.isNotEmpty) {
        filteredDateEvents
            .add(DateMockup(date: date.date, events: filteredEvents));
      }
    }

    return filteredDateEvents;
  }

  List<DateMockup> filterByStatus(
    List<DateMockup> dateEvents,
    bool showAnswered,
    bool showUndefined,
    bool showWarning,
  ) {
    List<DateMockup> filteredDateEvents = [];

    for (var date in dateEvents) {
      List<EventMockup> filteredEvents = date.events.where((event) {
        if (showUndefined && event.status == EventStatusEnum.undefined) {
          return true;
        }
        if (showAnswered &&
            (event.status == EventStatusEnum.accepted ||
                event.status == EventStatusEnum.declined ||
                event.status == EventStatusEnum.unknown)) {
          return true;
        }
        if (showWarning && event.status == EventStatusEnum.warning) {
          return true;
        }
        return !showUndefined && !showAnswered && !showWarning;
      }).toList();

      if (filteredEvents.isNotEmpty) {
        filteredDateEvents
            .add(DateMockup(date: date.date, events: filteredEvents));
      }
    }

    return filteredDateEvents;
  }

  List<DateMockup> getEventsByDate(DateTime date, List<DateMockup> dateEvents) {
    for (var eventsDate in dateEvents) {
      if (DateUtils.isSameDay(DateTime.parse(eventsDate.date), date)) {
        return [eventsDate];
      }
    }
    return [];
  }
}
