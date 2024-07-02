import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events.dart';

class StatusFilterState {
  final bool showUndefined;
  final bool showAnswered;
  final bool showWarning;

  StatusFilterState(
      {required this.showUndefined,
      required this.showAnswered,
      required this.showWarning});

  List<DateMockup> filterEvents(List<DateMockup> dateEvents) {
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

  StatusFilterState copyWith({
    bool? showUndefined,
    bool? showAnswered,
    bool? showWarning,
  }) {
    return StatusFilterState(
        showUndefined: showUndefined ?? this.showUndefined,
        showAnswered: showAnswered ?? this.showAnswered,
        showWarning: showWarning ?? this.showWarning);
  }
}
