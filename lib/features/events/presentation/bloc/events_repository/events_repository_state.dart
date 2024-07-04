import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:flutter/material.dart';

class EventsRepositoryState {
  final List<DateMockup> events;

  EventsRepositoryState({required this.events});

  EventsRepositoryState copyWith({
    List<DateMockup>? events,
  }) {
    return EventsRepositoryState(
      events: events ?? this.events,
    );
  }

  // TODO: Find a better way to do this. maybe different representation of the same data? Events by date should be direct access through map
  List<String> getEventsNameByDate(DateTime date) {
    for (var eventsDate in events) {
      if (DateUtils.isSameDay(DateTime.parse(eventsDate.date), date)) {
        return [for (var event in eventsDate.events) event.name];
      }
    }
    return [];
  }
}
