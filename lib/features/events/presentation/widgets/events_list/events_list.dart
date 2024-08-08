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
    final calendarFormat =
        context.watch<EventsCalendarBloc>().state.calendarFormat;
    final eventsViewMode =
        context.watch<EventsViewModeBloc>().state.eventsViewMode;

    return Visibility(
      visible: !(calendarFormat == CalendarFormat.month &&
          eventsViewMode == EventsViewModeEnum.calendar),
      child: _listView(),
    );
  }

  Widget _listView() {
    return BlocBuilder<EventsListBloc, EventsListState>(
      builder: (context, state) {
        final sortedDates = state.events.keys.toList()..sort();
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
        _buildDateHeader(date, context),
        Column(
            children: events
                .map((event) => _buildEventCard(event, context))
                .toList()),
      ],
    );
  }

  Widget _buildDateHeader(DateTime date, BuildContext context) {
    return Padding(
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
      ),
    );
  }

  Widget _buildEventCard(EventEntity event, BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(eventRoute, arguments: event),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: _getStatusBackgroundColor(event.status),
        elevation: 0.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          leading: CircleAvatar(
            backgroundColor: _getStatusColor(event.status),
            child: Icon(_getStatusIcon(event.status), color: Colors.white),
          ),
          title: Text(event.title),
          subtitle: Text('${event.address} - ${event.dateHour}'),
          trailing:
              SvgPicture.asset(_getTypeIcon(event.type), width: 50, height: 50),
        ),
      ),
    );
  }

  IconData _getStatusIcon(EventStatusEnum status) =>
      const {
        EventStatusEnum.accepted: Icons.check,
        EventStatusEnum.declined: Icons.close,
        EventStatusEnum.unknown: Icons.help_outline,
        EventStatusEnum.undefined: Icons.remove,
        EventStatusEnum.warning: Icons.warning,
      }[status] ??
      Icons.help_outline;

  String _getTypeIcon(EventTypeEnum type) =>
      const {
        EventTypeEnum.activity: AppIcons.activityIcon,
        EventTypeEnum.training: AppIcons.trainingIcon,
        EventTypeEnum.performance: AppIcons.performanceIcon,
      }[type] ??
      AppIcons.miniArrowRight;

  Color _getStatusBackgroundColor(EventStatusEnum status) =>
      const {
        EventStatusEnum.accepted: Color.fromRGBO(202, 245, 195, 1),
        EventStatusEnum.declined: Color.fromRGBO(245, 127, 141, 1),
        EventStatusEnum.unknown: Color.fromRGBO(249, 208, 130, 1),
        EventStatusEnum.undefined: Color.fromRGBO(202, 196, 208, 1),
        EventStatusEnum.warning: Color.fromRGBO(202, 245, 195, 1),
      }[status] ??
      const Color.fromRGBO(202, 196, 208, 1);

  Color _getStatusColor(EventStatusEnum status) =>
      const {
        EventStatusEnum.accepted: Colors.green,
        EventStatusEnum.declined: Colors.red,
        EventStatusEnum.unknown: Colors.orange,
        EventStatusEnum.undefined: Colors.grey,
        EventStatusEnum.warning: Colors.orange,
      }[status] ??
      Colors.grey;
}
