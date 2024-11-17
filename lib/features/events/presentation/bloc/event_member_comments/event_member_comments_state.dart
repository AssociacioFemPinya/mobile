part of 'event_member_comments_bloc.dart';


sealed class EventMemberCommentsState extends Equatable {
  const EventMemberCommentsState();
  
  @override
  List<Object> get props => [];
}

class EventMemberCommentsInitial extends EventMemberCommentsState {}

class EventMemberCommentsLoaded extends EventMemberCommentsState {
  final List<EventMemberCommentEntity> evenMemberComments;

  const EventMemberCommentsLoaded({required this.evenMemberComments});

  @override
  List<Object> get props => [evenMemberComments];
}
