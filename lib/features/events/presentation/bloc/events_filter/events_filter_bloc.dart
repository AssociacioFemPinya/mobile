import 'events_filter_events.dart';
import 'events_filter_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class EventsFilterBloc extends Bloc<EventsFilterEvent, EventsFilterState> {
  EventsFilterBloc()
      : super(EventsFilterState(
          showUndefined: false,
          showAnswered: false,
          showWarning: false,
        )) {
    on<EventsStatusFilterUndefined>((event, emit) {
      emit(state.copyWith(showUndefined: event.value));
    });
    on<EventsStatusFilterAnswered>((event, emit) {
      emit(state.copyWith(showAnswered: event.value));
    });
    on<EventsStatusFilterWarning>((event, emit) {
      emit(state.copyWith(showWarning: event.value));
    });
  }
}
