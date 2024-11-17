import 'package:equatable/equatable.dart';
import 'package:fempinya3_flutter_app/features/events/data/models/event_member_comment.dart';

class EventMemberCommentEntity extends Equatable {
  final DateTime date;
  //TODO User object integration
  final String user;
  final String comment;

  const EventMemberCommentEntity({
    required this.date,
    required this.user,
    required this.comment,
  });

  @override
  List<Object?> get props {
    return [date, user, comment];
  }

  // Factory constructor to create an EventEntity from EventModel
  factory EventMemberCommentEntity.fromModel(EventMemberCommentModel model) {
    return EventMemberCommentEntity(
      date: model.date ?? DateTime.now(),
      user: model.user,
      comment: model.comment,
    );
  }

  // Convert the entity to EventModel
  EventMemberCommentModel toModel() {
    return EventMemberCommentModel(
      date: date,
      user: user,
      comment: comment,
    );
  }

  EventMemberCommentEntity copyWith({bool? isEnabled}) {
    return EventMemberCommentEntity(
      date: date,
      user: user,
      comment: comment,
    );
  }
}
