import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_events_list.dart';
import 'package:fempinya3_flutter_app/features/events/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'events_list_events.dart';
part 'events_list_state.dart';

class EventsListBloc
    extends Bloc<EventsListEvent, EventsListState> {
  EventsListBloc()
      : super(EventsListState(
          events: {},
        )) {
    on<EventsListLoaded>((events, emit) {
      final DateEvents dateEvents = {};
      for (var event in events.value) {
        final eventDay = DateTime.utc(
            event.startDate.year, event.startDate.month, event.startDate.day);
        if (!dateEvents.containsKey(eventDay)) {
          dateEvents[eventDay] = [];
        }
        dateEvents[eventDay]!.add(event);
      }
      emit(EventsListLoadSuccess(dateEvents));
    });

    on<LoadEventsList>((events, emit) async {
      var result = await sl<GetEventsList>().call();

      result.fold((failure) {
        emit(EventsListLoadFailure('Failed to load events'));
      }, (data) {
        add(EventsListLoaded(data));
      });
    });
  }
}
