import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event_member_comment.dart';

part 'event_member_comments_event.dart';
part 'event_member_comments_state.dart';

class EventMemberCommentsBloc extends Bloc<EventMemberCommentsEvent, EventMemberCommentsState> {
  EventMemberCommentsBloc() : super(EventMemberCommentsInitial()) {
    on<LoadEventMemberComments>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const EventMemberCommentsLoaded(
          evenMemberComments: <EventMemberCommentEntity>[]));
    });
    on<AddEventMemberComment>((event, emit) {
      if (state is EventMemberCommentsLoaded) {
        final state = this.state as EventMemberCommentsLoaded;

        emit(EventMemberCommentsLoaded(
          evenMemberComments: List.from(state.evenMemberComments)
            ..add(event.eventMemberCommentEntity),
        ));
      }
    });
  }
}
