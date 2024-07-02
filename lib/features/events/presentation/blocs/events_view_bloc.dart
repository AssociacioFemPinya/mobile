import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'events_view_events.dart';
import 'events_view_state.dart';


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

// class EventsViewFilterState {
//   // selectableFilters holds the list of filters from the dropDown menu, based on event tags
//   final List<String> selectableFilters;
//   // statusFilters holds the value of the filters based on whether the event has been replied or if it requires attention
//   final Map<StatusFilters, bool> statusFilters;

//   EventsViewFilterState({
//     required this.selectableFilters,
//     required this.statusFilters,
//   });
// }

// enum ViewMode {
//   list,
//   calendar,
// }

// class EventsViewModeState {
//   // viewMode is used to define whether the events should be presented through a list or through a calendar
//   final ViewMode viewMode;

//   EventsViewModeState({
//     required this.viewMode,
//   });
// }

// class EventsViewListState {
//   // events store the list of events after applying the necessary filters
//   final List<EventEntity> events;

//   EventsViewListState({
//     required this.events,
//   });
// }

// class EventsViewState {
//   final EventsViewFilterState filterState;
//   final EventsViewModeState viewModeState;
//   final EventsViewListState listState;

//   EventsViewState({
//     required this.filterState,
//     required this.viewModeState,
//     required this.listState,
//   });

//   static final EventsViewState initial = EventsViewState(
//     filterState: EventsViewFilterState(selectableFilters: [], statusFilters: {}),
//     viewModeState: EventsViewModeState(viewMode: ViewMode.list),
//     listState: EventsViewListState(events: []),
//   );
// }
