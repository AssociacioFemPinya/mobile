import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/useCases/post_event.dart';
import 'package:fempinya3_flutter_app/features/events/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_view_events.dart';
part 'event_view_state.dart';

class EventViewBloc extends Bloc<EventViewEvent, EventViewState> {
  EventViewBloc() : super(EventViewInitial(event: null)) {
    on<LoadEvent>((eventID, emit) async {
      GetEventParams getEventParams = GetEventParams(id: eventID.value);
      var result = await sl<GetEvent>().call(params: getEventParams);

      result.fold((failure) {
        add(EventLoadFailure(failure));
      }, (data) {
        add(EventLoadSuccess(data));
      });
    });

    on<EventLoadSuccess>((event, emit) {
      emit(EventViewEventLoaded(event: event.value));
    });

    on<EventLoadFailure>((errorMessage, emit) {
      // TODO
    });

    on<UpdateEvent>((event, emit) async {
      var result = await sl<PostEvent>().call(params: event.value);

      result.fold((failure) {
        add(EventUpdateFailure(failure));
      }, (data) {
        add(EventUpdateSuccess(data));
      });
    });

    on<EventUpdateSuccess>((event, emit) {
      emit(EventViewEventUpdated(event: event.value));
    });

    on<EventUpdateFailure>((errorMessage, emit) {
      // TODO
    });

    on<EventStatusModified>((status, emit) async {
      var newEvent = state.event!.copyWith(status: status.value);
      add(UpdateEvent(newEvent));
    });

    on<EventCompanionsModified>((companions, emit) async {
      var newEvent = state.event!.copyWith(companions: companions.value);
      add(UpdateEvent(newEvent));
    });
  }
}
