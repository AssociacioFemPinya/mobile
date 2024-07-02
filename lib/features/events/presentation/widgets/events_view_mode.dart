import 'package:flutter/material.dart';

enum EventsViewMode { list, calendar }

class EventsViewModeWidged extends StatefulWidget {
  const EventsViewModeWidged({super.key});

  @override
  State<EventsViewModeWidged> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<EventsViewModeWidged> {
  EventsViewMode eventsViewMode = EventsViewMode.list;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<EventsViewMode>(
      segments: const <ButtonSegment<EventsViewMode>>[
        ButtonSegment<EventsViewMode>(
            value: EventsViewMode.list,
            label: Text('List'),
            icon: Icon(Icons.format_list_bulleted)),
        ButtonSegment<EventsViewMode>(
            value: EventsViewMode.calendar,
            label: Text('Calendar'),
            icon: Icon(Icons.calendar_view_week)),
      ],
      selected: <EventsViewMode>{eventsViewMode},
      onSelectionChanged: (Set<EventsViewMode> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          eventsViewMode = newSelection.first;
        });
      },
    );
  }
}
