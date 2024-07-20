import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_view_mode.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_calendar/events_calendar_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_calendar/events_calendar_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filters/events_filters_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view_mode/events_view_mode_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsViewModeWidget extends StatefulWidget {
  const EventsViewModeWidget({super.key});

  @override
  State<EventsViewModeWidget> createState() => _EventsViewModeWidgetState();
}

class _EventsViewModeWidgetState extends State<EventsViewModeWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late EventsViewModeEnum _currentViewMode;

  final Map<EventsViewModeEnum, Tab> _tabs = {
    EventsViewModeEnum.list: const Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.list, size: 20),
          SizedBox(width: 8),
          Text('Lista', style: TextStyle(fontSize: 16)),
        ],
      ),
    ),
    EventsViewModeEnum.calendar: const Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_month, size: 20),
          SizedBox(width: 8),
          Text('Calendario', style: TextStyle(fontSize: 16)),
        ],
      ),
    ),
  };

  late Map<EventsViewModeEnum, int> _tabIndexMap;

  @override
  void initState() {
    super.initState();

    _tabIndexMap = {
      EventsViewModeEnum.list: 0,
      EventsViewModeEnum.calendar: 1,
    };

    _tabController = TabController(length: _tabs.length, vsync: this)
      ..addListener(() {
        if (_tabController.indexIsChanging) {
          EventsViewModeEnum selectedMode = _tabIndexMap.entries
              .firstWhere((entry) => entry.value == _tabController.index)
              .key;
          _onTabChanged(selectedMode);
        }
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<EventsViewModeBloc>().state;
      _currentViewMode = state.eventsViewMode;
      _tabController.index = _tabIndexMap[_currentViewMode]!;
    });
  }

  void _onTabChanged(EventsViewModeEnum viewMode) {
    context.read<EventsViewModeBloc>().add(EventsViewModeSet(viewMode));
    if (viewMode == EventsViewModeEnum.list) {
      context.read<EventsFiltersBloc>().add(EventsDayFilterUnset());
    } else if (viewMode == EventsViewModeEnum.calendar) {
      context.read<EventsCalendarBloc>().add(EventsCalendarDateSelectedUnset());
      context
          .read<EventsCalendarBloc>()
          .add(EventsCalendarFormatSet(CalendarFormat.month));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsViewModeBloc, EventsViewModeState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            height: kToolbarHeight - 8.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey.shade200,
            ),
            child: TabBar(
              controller: _tabController,
              tabs: _tabs.values.toList(),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color.fromARGB(255, 45, 131, 236),
              ),
              indicatorPadding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
        );
      },
    );
  }
}
