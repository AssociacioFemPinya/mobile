import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view/events_view_mode_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view/events_view_mode_state.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_view_mode.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class EventsViewModeBloc
    extends Bloc<EventsViewModeEvent, EventsViewModeState> {
  EventsViewModeBloc()
      : super(EventsViewModeState(
          eventViewMode: EventsViewModeEnum.list,
        )) {
    on<EventsViewModeSet>((event, emit) {
      emit(state.copyWith(eventViewMode: event.value));
    });
  }
}
