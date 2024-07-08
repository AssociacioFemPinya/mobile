part of 'events_repository_bloc.dart';

class EventsRepositoryState {
  final DateEvents events;

  EventsRepositoryState({required this.events});

  EventsRepositoryState copyWith({
    DateEvents? events,
  }) {
    return EventsRepositoryState(
      events: events ?? this.events,
    );
  }

  // // TODO: Find a better way to do this. maybe different representation of the same data? Events by date should be direct access through map
  // List<String> getEventsNameByDate(DateTime date) {
  //   events.forEach((date, events) {
  // if (DateUtils.isSameDay(DateTime.parse(date), date)) {
  //       return [for (var event in events[date]) event.name];
  //     }
  //   });
    
  //   return [];
  // }
}
