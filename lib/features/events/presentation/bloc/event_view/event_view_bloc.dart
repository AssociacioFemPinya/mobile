import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_event.dart';
import 'package:fempinya3_flutter_app/features/events/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_view_events.dart';
part 'event_view_state.dart';

class EventViewBloc extends Bloc<EventViewEvent, EventViewState> {
  EventViewBloc() : super(EventViewState(event: null)) {
    on<EventLoadSuccess>((event, emit) {
      emit(state.copyWith(event: event.value));
    });

    on<LoadEvent>((eventID, emit) async {
      GetEventParams getEventParams = GetEventParams(id: eventID.value);
      var result = await sl<GetEvent>().call(params: getEventParams);

      result.fold((failure) {
        add(EventLoadFailure(failure));
      }, (data) {
        add(EventLoadSuccess(data));
      });
    });

    on<EventLoadFailure>((errorMessage, emit) {
      // TODO
    });
  }
}
