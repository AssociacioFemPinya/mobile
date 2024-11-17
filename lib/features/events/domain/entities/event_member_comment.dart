import 'package:equatable/equatable.dart';
import 'package:fempinya3_flutter_app/features/events/data/models/event_member_comment.dart';

class EventMemberCommentEntity extends Equatable {
  final String name;

  const EventMemberCommentEntity(
      {required this.name});

  @override
  List<Object?> get props {
    return [name];
  }

  // Factory constructor to create an EventEntity from EventModel
  factory EventMemberCommentEntity.fromModel(EventMemberCommentModel model) {
    return EventMemberCommentEntity(
      name: model.name,
    );
  }

  // Convert the entity to EventModel
  EventMemberCommentModel toModel() {
    return EventMemberCommentModel(
      name: name
    );
  }

  EventMemberCommentEntity copyWith({bool? isEnabled}) {
    return EventMemberCommentEntity(
      name: name
    );
  }
}
