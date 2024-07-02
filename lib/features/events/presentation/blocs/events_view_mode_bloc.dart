import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/blocs/events_view_mode_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/blocs/events_view_mode_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_view_mode.dart';


class EventsViewModeBloc extends Bloc<EventsViewModeEvent, EventsViewModeState> {
  EventsViewModeBloc(List<DateMockup> dateEvents) : super(EventsViewModeState(
    eventViewMode: EventsViewModeEnum.list,
  )) {
    on<EventViewModeList>((event, emit) {
      emit(state.copyWith(eventViewMode: EventsViewModeEnum.list));
    });
    on<EventViewModeCalendar>((event, emit) {
      emit(state.copyWith(eventViewMode: EventsViewModeEnum.calendar));
    });
  }
}
