import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';

class EventsFilterState {
  final bool showUndefined;
  final bool showAnswered;
  final bool showWarning;
  final List<EventTypeEnum> eventTypeFilters;

  EventsFilterState(
      {required this.showUndefined,
      required this.showAnswered,
      required this.showWarning,
      required this.eventTypeFilters});

  EventsFilterState copyWith({
    bool? showUndefined,
    bool? showAnswered,
    bool? showWarning,
    List<EventTypeEnum>? eventTypeFilters,
  }) {
    return EventsFilterState(
        showUndefined: showUndefined ?? this.showUndefined,
        showAnswered: showAnswered ?? this.showAnswered,
        showWarning: showWarning ?? this.showWarning,
        eventTypeFilters: eventTypeFilters ?? this.eventTypeFilters);
  }

  // TODO: All this should happen at backend with query params, not filtering at app level
  List<DateMockup> filterEvents(List<DateMockup> dateEvents) {
    return filterByStatus(filterByType(dateEvents));
  }

  List<DateMockup> filterByType(List<DateMockup> dateEvents) {
    if (eventTypeFilters.isEmpty) {
      return dateEvents;
    }
    List<DateMockup> filteredDateEvents = [];
    for (var date in dateEvents) {
      List<EventMockup> filteredEvents = [];
      filteredEvents.addAll(date.events.where((event) {
        return eventTypeFilters.contains(event.type);
      }));

      if (filteredEvents.isNotEmpty) {
        filteredDateEvents
            .add(DateMockup(date: date.date, events: filteredEvents));
      }
    }

    return filteredDateEvents;
  }

  List<DateMockup> filterByStatus(List<DateMockup> dateEvents) {
    List<DateMockup> filteredDateEvents = [];
    for (var date in dateEvents) {
      List<EventMockup> filteredEvents = [];

      filteredEvents.addAll(date.events.where((event) {
        if (showUndefined && event.status == EventStatusEnum.undefined) {
          return true;
        }
        if (showAnswered &&
            (event.status == EventStatusEnum.accepted ||
                event.status == EventStatusEnum.declined ||
                event.status == EventStatusEnum.unknown)) return true;
        if (showWarning && event.status == EventStatusEnum.warning) return true;
        return !showUndefined && !showAnswered && !showWarning;
      }));

      if (filteredEvents.isNotEmpty) {
        filteredDateEvents
            .add(DateMockup(date: date.date, events: filteredEvents));
      }
    }
    return filteredDateEvents;
  }
}
