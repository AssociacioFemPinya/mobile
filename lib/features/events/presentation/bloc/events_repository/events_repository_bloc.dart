import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_events_list.dart';
import 'package:fempinya3_flutter_app/features/events/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'events_repository_events.dart';
part 'events_repository_state.dart';
class EventsRepositoryBloc
    extends Bloc<EventsRepositoryEvent, EventsRepositoryState> {
  EventsRepositoryBloc()
      : super(EventsRepositoryState(
          events: {},
        ));

  Future<void> getEventsList() async {
    var events = await sl<GetEventsList>().call();

    events.fold(
      (l) {
        // TODO: handle error
      },
      (data) {
        emit(
          EventsListLoaded(listEvents: data)
        );
      }
    );
  }
}
