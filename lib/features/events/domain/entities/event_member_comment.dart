import 'package:equatable/equatable.dart';
import 'package:fempinya3_flutter_app/features/events/data/models/event_member_comment.dart';

class EventMemberCommentEntity extends Equatable {
  final DateTime date;
  final String comment;

  const EventMemberCommentEntity({
    required this.date,
    required this.comment,
  });

  @override
  List<Object?> get props {
    return [date, comment];
  }

  // Factory constructor to create an EventEntity from EventModel
  factory EventMemberCommentEntity.fromModel(EventMemberCommentModel model) {
    return EventMemberCommentEntity(
      date: model.date ?? DateTime.now(),
      comment: model.comment,
    );
  }

  // Convert the entity to EventModel
  EventMemberCommentModel toModel() {
    return EventMemberCommentModel(
      date: date,
      comment: comment
    );
  }

  EventMemberCommentEntity copyWith({bool? isEnabled}) {
    return EventMemberCommentEntity(
      date: date,
      comment: comment
    );
  }
}
