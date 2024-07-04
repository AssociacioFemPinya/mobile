import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';

class EventsFiltersState {
  final bool showUndefined;
  final bool showAnswered;
  final bool showWarning;
  final List<EventTypeEnum> eventTypeFilters;

  EventsFiltersState(
      {required this.showUndefined,
      required this.showAnswered,
      required this.showWarning,
      required this.eventTypeFilters});

  EventsFiltersState copyWith({
    bool? showUndefined,
    bool? showAnswered,
    bool? showWarning,
    List<EventTypeEnum>? eventTypeFilters,
  }) {
    return EventsFiltersState(
        showUndefined: showUndefined ?? this.showUndefined,
        showAnswered: showAnswered ?? this.showAnswered,
        showWarning: showWarning ?? this.showWarning,
        eventTypeFilters: eventTypeFilters ?? this.eventTypeFilters);
  }
}
