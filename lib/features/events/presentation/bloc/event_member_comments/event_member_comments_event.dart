part of 'event_member_comments_bloc.dart';

sealed class EventMemberCommentsEvent extends Equatable {
  const EventMemberCommentsEvent();

  @override
  List<Object> get props => [];
}

class LoadEventMemberComments extends EventMemberCommentsEvent {
}

class AddEventMemberComment extends EventMemberCommentsEvent {
  final EventMemberCommentEntity eventMemberCommentEntity;

  const AddEventMemberComment(this.eventMemberCommentEntity);

  @override
  List<Object> get props => [eventMemberCommentEntity];
}