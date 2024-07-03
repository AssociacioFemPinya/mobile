import 'package:fempinya3_flutter_app/features/events/domain/enums/events_view_mode.dart';

class EventsViewModeEvent {}

class EventsViewModeSet extends EventsViewModeEvent {
  final EventsViewModeEnum value;
  EventsViewModeSet(this.value);
}
