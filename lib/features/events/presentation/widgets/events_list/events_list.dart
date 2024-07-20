import 'package:fempinya3_flutter_app/core/configs/assets/app_icons.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_view_mode.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_filters/events_filters_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_list/events_list_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_view_mode/events_view_mode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class EventsListWidget extends StatelessWidget {
  const EventsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final eventsFiltersState = context.watch<EventsFiltersBloc>().state;
    late final eventsRepositoryState =
        context.watch<EventsListBloc>().state;
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
      DateTime date, List<EventEntity> events, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.calendar_month),
                Text(
                  formatDateToHumanLanguage(
                      date, Localizations.localeOf(context).toString()),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            )),
        Column(
          children:
              events.map((event) => _buildEventCard(event, context)).toList(),
        ),
      ],
    );
  }

  Widget _buildEventCard(EventEntity event, BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(eventRoute, arguments: event);
        },
        child: Card(
          color: _getStatusBackgroundColor(event.status),
          elevation: 0.0,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(event.status),
              child: Icon(_getStatusIcon(event.status), color: Colors.white),
            ),
            title: Text(event.title),
            subtitle: Text('${event.address} - ${event.dateHour}'),
            // TODO: Fix the icon assignment, is not the right function
            trailing: SvgPicture.asset(
              _getTypeIcon(event.type),
              width: 60,
              height: 60,
            ),
          ),
        ));
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

  String _getTypeIcon(EventTypeEnum type) {
    switch (type) {
      case EventTypeEnum.activity:
        return AppIcons.activityIcon;
      case EventTypeEnum.training:
        return AppIcons.trainingIcon;
      case EventTypeEnum.performance:
        return AppIcons.performanceIcon;
      default:
        return AppIcons.miniArrowRight;
    }
  }

  Color _getStatusBackgroundColor(EventStatusEnum status) {
    switch (status) {
      case EventStatusEnum.accepted:
        return Color.fromRGBO(202, 245, 195, 100);
      case EventStatusEnum.declined:
        return const Color.fromRGBO(245, 127, 141, 100);
      case EventStatusEnum.unknown:
        return const Color.fromRGBO(249, 208, 130, 100);
      case EventStatusEnum.undefined:
        return const Color.fromRGBO(202, 196, 208, 100);
      case EventStatusEnum.warning:
        return Color.fromRGBO(202, 245, 195, 100);
      default:
        return const Color.fromRGBO(202, 196, 208, 100);
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

    DateEvents events = dayFilterEnabled && dayFilter != null
        ? getEventsByDate(dayFilter, dateEvents)
        : dateEvents;
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
      List<EventEntity> filteredEvents = events.where((event) {
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
      List<EventEntity> filteredEvents = events.where((event) {
        if (showUndefined && event.status == EventStatusEnum.undefined) {
          return true;
        }
        if (showAnswered &&
            (event.status == EventStatusEnum.accepted ||
                event.status == EventStatusEnum.declined ||
                event.status == EventStatusEnum.warning ||
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
    List<EventEntity>? events = dateEvents[date];
    return {date: events ?? []};
  }

  String formatDateToHumanLanguage(DateTime date, String locale) {
    // TODO: this is not reloading when the user changes the language
    // Initialize date format for the given locale
    final DateFormat dateFormat = DateFormat.yMMMMd(locale);

    // Format the date
    return dateFormat.format(date);
  }
}
