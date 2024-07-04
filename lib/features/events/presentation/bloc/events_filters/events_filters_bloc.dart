import 'events_filters_events.dart';
import 'events_filters_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class EventsFiltersBloc extends Bloc<EventsFiltersEvent, EventsFiltersState> {
  EventsFiltersBloc()
      : super(EventsFiltersState(
          showUndefined: false,
          showAnswered: false,
          showWarning: false,
          eventTypeFilters: [],
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
    on<EventsTypeFiltersAdd>((event, emit) {
      if (!state.eventTypeFilters.contains(event.value)) {
        emit(state.copyWith(
            eventTypeFilters: List.from(state.eventTypeFilters)
              ..add(event.value)));
      }
    });
    on<EventsTypeFiltersRemove>((event, emit) {
      if (state.eventTypeFilters.contains(event.value)) {
        emit(state.copyWith(
            eventTypeFilters: List.from(state.eventTypeFilters)
              ..remove(event.value)));
      }
    });
  }
}
