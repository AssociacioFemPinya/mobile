class EventMemberCommentModel {
  final DateTime? date;
  final String comment;

  EventMemberCommentModel({required this.date, required this.comment});

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date?.toIso8601String(),
      'comment': comment,
    };
  }

  // Factory constructor for JSON deserialization
  factory EventMemberCommentModel.fromJson(Map<String, dynamic> data) {
    return EventMemberCommentModel(
      date: data['date'] != null ? DateTime.tryParse(data['date']) : null,
      comment: data['comment'] as String,
    );
  }
}
