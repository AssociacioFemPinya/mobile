import 'package:fempinya3_flutter_app/features/events/domain/enums/events_view_mode.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view_mode/events_view_mode_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view_mode/events_view_mode_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view_mode/events_view_mode_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsViewModeWidget extends StatelessWidget {
  const EventsViewModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsViewModeBloc, EventsViewModeState>(
        builder: (context, state) {
      return SegmentedButton<EventsViewModeEnum>(
        segments: const <ButtonSegment<EventsViewModeEnum>>[
          ButtonSegment<EventsViewModeEnum>(
              value: EventsViewModeEnum.list,
              label: Text('List'),
              icon: Icon(Icons.format_list_bulleted)),
          ButtonSegment<EventsViewModeEnum>(
              value: EventsViewModeEnum.calendar,
              label: Text('Calendar'),
              icon: Icon(Icons.calendar_view_week)),
        ],
        selected: <EventsViewModeEnum>{
          context.read<EventsViewModeBloc>().state.eventsViewMode
        },
        onSelectionChanged: (Set<EventsViewModeEnum> newSelection) {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          context
              .read<EventsViewModeBloc>()
              .add(EventsViewModeSet(newSelection.first));
        },
      );
    });
  }
}
