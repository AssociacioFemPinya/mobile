import 'package:fempinya3_flutter_app/core/configs/assets/app_icons.dart';
import 'package:fempinya3_flutter_app/core/utils/datetime_utils.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_view_mode.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_calendar/events_calendar_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_list/events_list_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_view_mode/events_view_mode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsListWidget extends StatelessWidget {
  const EventsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final calendarFormat =
        context.watch<EventsCalendarBloc>().state.calendarFormat;
    late final eventsViewMode =
        context.watch<EventsViewModeBloc>().state.eventsViewMode;

    return Visibility(
        visible: !(calendarFormat == CalendarFormat.month &&
            eventsViewMode == EventsViewModeEnum.calendar),
        child: _listView());
  }

  BlocBuilder _listView() {
    return BlocBuilder<EventsListBloc, EventsListState>(
      builder: (context, state) {
        // Extract and sort the dates
        final sortedDates = state.events.keys.toList()
          ..sort((a, b) => a.compareTo(b));

        return ListView.separated(
          itemCount: sortedDates.length,
          separatorBuilder: (context, index) =>
              const Divider(thickness: 1, indent: 20, endIndent: 20),
          itemBuilder: (context, index) {
            final date = sortedDates[index];
            final events = state.events[date] ?? [];

            return _buildDateEventsList(date, events, context);
          },
        );
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
                  DateTimeUtils.formatDateToHumanLanguage(
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: _getStatusBackgroundColor(event.status),
        elevation: 0.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 8.0), // Ajusta el margen interno del ListTile
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(event.status),
              child: Icon(_getStatusIcon(event.status), color: Colors.white),
            ),
            title: Text(event.title),
            subtitle: Text('${event.address} - ${event.dateHour}'),
            trailing: SvgPicture.asset(
              _getTypeIcon(event.type),
              width: 50, // Ajusta el ancho del ícono
              height: 50, // Ajusta la altura del ícono
            ),
          ),
        ),
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
}
