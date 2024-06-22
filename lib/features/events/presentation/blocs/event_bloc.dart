import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:fempinya3_flutter_app/features/events/data/models/event.dart'; // Replace with actual Event model import


enum StatusFilters {
  missingReply,
  replied,
  requiresAttention,
}

class EventFilterState {
  // selectableFilters holds the list of filters from the dropDown menu, based on event tags
  final List<String> selectableFilters;
  // statusFilters holds the value of the filters based on whether the event has been replied or if it requires attention
  final Map<StatusFilters, bool> statusFilters;

  EventFilterState({
    required this.selectableFilters,
    required this.statusFilters,
  });
}

enum ViewMode {
  list,
  calendar,
}

class EventListViewModeState {
  // viewMode is used to define whether the events should be presented through a list or through a calendar
  final ViewMode viewMode;

  EventListViewModeState({
    required this.viewMode,
  });
}

class EventListState {
  // events store the list of events after applying the necessary filters
  final List<Event> events;

  EventListState({
    required this.events,
  });
}

class EventState {
  final EventFilterState filterState;
  final EventListViewModeState viewModeState;
  final EventListState listState;

  EventState({
    required this.filterState,
    required this.viewModeState,
    required this.listState,
  });

  static final EventState initial = EventState(
    filterState: EventFilterState(selectableFilters: [], statusFilters: {}),
    viewModeState: EventListViewModeState(viewMode: ViewMode.list),
    listState: EventListState(events: []),
  );
}

// Events
@immutable
abstract class EventEvent {}

class FetchEventListEvent extends EventEvent {}

// Bloc
class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventState.initial);

  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is FetchEventListEvent) {
      yield* _mapFetchEventListEventToState();
    }
  }

  Stream<EventState> _mapFetchEventListEventToState() async* {
    yield EventState(
      filterState: state.filterState,
      viewModeState: state.viewModeState,
      listState: EventListState(events: []),
    );

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Replace with actual API call logic to fetch events
      List<Event> events = [Event(id: 1, name: 'Event 1'), Event(id: 2, name: 'Event 2')];
      
      // Emit success event with fetched events
      yield EventState(
        filterState: state.filterState,
        viewModeState: state.viewModeState,
        listState: EventListState(events: events),
      );
    } catch (e) {
      // Emit failure event with error message
      yield EventState(
        filterState: state.filterState,
        viewModeState: state.viewModeState,
        listState: state.listState,
      );
    }
  }
}
