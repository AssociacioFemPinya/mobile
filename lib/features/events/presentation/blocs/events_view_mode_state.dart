import 'package:fempinya3_flutter_app/features/events/domain/enums/events_view_mode.dart';

class EventsViewModeState {
  final EventsViewModeEnum eventViewMode;

  EventsViewModeState(
      {required this.eventViewMode});

  EventsViewModeState copyWith({
    EventsViewModeEnum? eventViewMode,
  }) {
    return EventsViewModeState(
        eventViewMode: eventViewMode ?? this.eventViewMode,
    );
  }
}
