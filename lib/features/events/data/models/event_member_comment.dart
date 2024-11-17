class EventMemberCommentModel {
  final String comment;

  EventMemberCommentModel({required this.comment});

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
    };
  }

  // Factory constructor for JSON deserialization
  factory EventMemberCommentModel.fromJson(Map<String, dynamic> data) {
    return EventMemberCommentModel(
      comment: data['comment'] as String,
    );
  }
}
