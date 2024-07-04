import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_repository/events_repository_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_repository/events_repository_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsRepositoryBloc
    extends Bloc<EventsRepositoryEvent, EventsRepositoryState> {
  EventsRepositoryBloc()
      : super(EventsRepositoryState(
          events: generateMockup(),
        ));
}
