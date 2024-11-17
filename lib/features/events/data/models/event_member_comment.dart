class EventMemberCommentModel {
  final DateTime? date;
  //TODO User object integration
  final String user;
  final String comment;

  EventMemberCommentModel({
    required this.date, 
    required this.user, 
    required this.comment});

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date?.toIso8601String(),
      'user': user,
      'comment': comment,
    };
  }

  // Factory constructor for JSON deserialization
  factory EventMemberCommentModel.fromJson(Map<String, dynamic> data) {
    return EventMemberCommentModel(
      date: data['date'] != null ? DateTime.tryParse(data['date']) : null,
      user: data['user'] as String,
      comment: data['comment'] as String,
    );
  }
}
