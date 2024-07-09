import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_view_mode.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filters/events_filters_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_repository/events_repository_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view_mode/events_view_mode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsListWidget extends StatelessWidget {
  const EventsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final eventsFiltersState = context.watch<EventsFiltersBloc>().state;
    late final eventsRepositoryState =
        context.watch<EventsRepositoryBloc>().state;
    late final eventsViewModeState = context.watch<EventsViewModeBloc>().state;

    final filteredEvents = filterEvents(
      eventsRepositoryState.events,
      eventsViewModeState.eventsViewMode,
      eventsFiltersState.eventTypeFilters,
      eventsFiltersState.dayFilter,
      eventsFiltersState.dayFilterEnabled,
      eventsFiltersState.showAnswered,
      eventsFiltersState.showUndefined,
      eventsFiltersState.showWarning,
    );

    return ListView.separated(
      itemCount: filteredEvents.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final date = filteredEvents.keys.toList()[index];
        final events = filteredEvents[date] ?? [];

        return _buildDateEventsList(date, events, context);
      },
    );
  }

  Widget _buildDateEventsList(
      DateTime date, List<EventMockup> events, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            date.toString(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Column(
          children: events.map((event) => _buildEventCard(event)).toList(),
        ),
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

  DateEvents filterEvents(
    DateEvents dateEvents,
    EventsViewModeEnum eventsViewMode,
    List<EventTypeEnum> eventTypeFilters,
    DateTime? dayFilter,
    bool dayFilterEnabled,
    bool showAnswered,
    bool showUndefined,
    bool showWarning,
  ) {
    if (eventsViewMode == EventsViewModeEnum.calendar && !dayFilterEnabled) {
      return {};
    }

    DateEvents events =
        dayFilterEnabled && dayFilter != null ? getEventsByDate(dayFilter, dateEvents) : dateEvents;
    DateEvents filteredEventsByType = filterByType(events, eventTypeFilters);
    return filterByStatus(
      filteredEventsByType,
      showAnswered,
      showUndefined,
      showWarning,
    );
  }

  DateEvents filterByType(
    DateEvents dateEvents,
    List<EventTypeEnum> eventTypeFilters,
  ) {
    if (eventTypeFilters.isEmpty) {
      return dateEvents;
    }

    DateEvents filteredDateEvents = {};

    dateEvents.forEach((date, events) {
      List<EventMockup> filteredEvents = events.where((event) {
        return eventTypeFilters.contains(event.type);
      }).toList();

      if (filteredEvents.isNotEmpty) {
        filteredDateEvents[date] = filteredEvents;
      }
    });

    return filteredDateEvents;
  }

  DateEvents filterByStatus(
    DateEvents dateEvents,
    bool showAnswered,
    bool showUndefined,
    bool showWarning,
  ) {
    DateEvents filteredDateEvents = {};

    dateEvents.forEach((date, events) {
      List<EventMockup> filteredEvents = events.where((event) {
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
        filteredDateEvents[date] = filteredEvents;
      }
    });

    return filteredDateEvents;
  }

  DateEvents getEventsByDate(DateTime date, DateEvents dateEvents) {
    List<EventMockup>? events = dateEvents[date];
    return {date: events ?? []};
  }
}
