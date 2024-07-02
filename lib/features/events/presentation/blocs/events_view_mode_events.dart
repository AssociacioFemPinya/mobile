import 'package:fempinya3_flutter_app/features/events/domain/enums/events_view_mode.dart';

class EventsViewModeEvent {}

class EventViewModeList extends EventsViewModeEvent {
  EventViewModeList();
}

class EventViewModeCalendar extends EventsViewModeEvent {
  EventViewModeCalendar();
}
