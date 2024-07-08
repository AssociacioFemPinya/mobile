import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'events_repository_events.dart';
part 'events_repository_state.dart';
class EventsRepositoryBloc
    extends Bloc<EventsRepositoryEvent, EventsRepositoryState> {
  EventsRepositoryBloc()
      : super(EventsRepositoryState(
          events: generateMockup(),
        ));
}
