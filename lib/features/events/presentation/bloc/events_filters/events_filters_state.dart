part of 'events_filters_bloc.dart';

class EventsFiltersState extends Equatable {
  final bool showUndefined;
  final bool showAnswered;
  final bool showWarning;
  final List<EventTypeEnum> eventTypeFilters;
  final DateTime? dayFilter;

  const EventsFiltersState(
      {required this.showUndefined,
      required this.showAnswered,
      required this.showWarning,
      required this.eventTypeFilters,
      required this.dayFilter});

  EventsFiltersState copyWith({
    bool? showUndefined,
    bool? showAnswered,
    bool? showWarning,
    List<EventTypeEnum>? eventTypeFilters,
    DateTime? dayFilter,
    bool? dayFilterEnabled,
  }) {
    return EventsFiltersState(
        showUndefined: showUndefined ?? this.showUndefined,
        showAnswered: showAnswered ?? this.showAnswered,
        showWarning: showWarning ?? this.showWarning,
        eventTypeFilters: eventTypeFilters ?? this.eventTypeFilters,
        dayFilter: dayFilter);
  }

  @override
  List<Object?> get props => [
        showUndefined,
        showAnswered,
        showWarning,
        eventTypeFilters,
        dayFilter,
      ];
}
