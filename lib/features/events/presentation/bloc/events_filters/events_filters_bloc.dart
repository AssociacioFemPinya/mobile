import 'package:equatable/equatable.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'events_filters_state.dart';
part 'events_filters_events.dart';

class EventsFiltersBloc extends Bloc<EventsFiltersEvent, EventsFiltersState> {
  EventsFiltersBloc()
      : super(const EventsFiltersState(
          showUndefined: false,
          showAnswered: false,
          showWarning: false,
          eventTypeFilters: [],
          // TODO: Is it possible to handle dayFilter as non-nullable?? Having nullable values in
          // bloc is annoying due to copyWith function
          dayFilter: null,
        )) {
    on<EventsStatusFilterUndefined>((event, emit) {
      emit(state.copyWith(
          showUndefined: event.value, dayFilter: state.dayFilter));
    });
    on<EventsStatusFilterAnswered>((event, emit) {
      emit(state.copyWith(
          showAnswered: event.value, dayFilter: state.dayFilter));
    });
    on<EventsStatusFilterWarning>((event, emit) {
      emit(
          state.copyWith(showWarning: event.value, dayFilter: state.dayFilter));
    });
    on<EventsTypeFiltersAdd>((event, emit) {
      if (!state.eventTypeFilters.contains(event.value)) {
        emit(state.copyWith(
            eventTypeFilters: List.from(state.eventTypeFilters)
              ..add(event.value),
            dayFilter: state.dayFilter));
      }
    });
    on<EventsTypeFiltersRemove>((event, emit) {
      if (state.eventTypeFilters.contains(event.value)) {
        emit(state.copyWith(
            eventTypeFilters: List.from(state.eventTypeFilters)
              ..remove(event.value),
            dayFilter: state.dayFilter));
      }
    });
    on<EventsDayFilterSet>((event, emit) {
      emit(state.copyWith(dayFilter: event.value));
    });
    on<EventsDayFilterUnset>((event, emit) {
      emit(state.copyWith(dayFilter: null));
    });
  }
}
