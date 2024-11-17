import 'package:equatable/equatable.dart';
import 'package:fempinya3_flutter_app/features/events/data/models/event_member_comment.dart';

class EventMemberCommentEntity extends Equatable {
  final String comment;

  const EventMemberCommentEntity(
      {required this.comment});

  @override
  List<Object?> get props {
    return [comment];
  }

  // Factory constructor to create an EventEntity from EventModel
  factory EventMemberCommentEntity.fromModel(EventMemberCommentModel model) {
    return EventMemberCommentEntity(
      comment: model.comment,
    );
  }

  // Convert the entity to EventModel
  EventMemberCommentModel toModel() {
    return EventMemberCommentModel(
      comment: comment
    );
  }

  EventMemberCommentEntity copyWith({bool? isEnabled}) {
    return EventMemberCommentEntity(
      comment: comment
    );
  }
}
