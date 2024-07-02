import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'events_filter_events.dart';
import 'events_filter_state.dart';


class StatusFilterBloc extends Bloc<StatusFilterEvent, StatusFilterState> {
  StatusFilterBloc(List<DateMockup> dateEvents) : super(StatusFilterState(
    showUndefined: false,
    showAnswered: false,
    showWarning: false,
  )) {
    on<StatusUndefined>((event, emit) {
      emit(state.copyWith(showUndefined: event.value));
    });
    on<StatusAnswered>((event, emit) {
      emit(state.copyWith(showAnswered: event.value));
    });
    on<StatusWarning>((event, emit) {
      emit(state.copyWith(showWarning: event.value));
    });
  }
}
