class EventMemberCommentModel {
  final int? id;
  final DateTime? date;
  //TODO User object integration
  final String user;
  final String comment;

  EventMemberCommentModel({
    required this.id, 
    required this.date, 
    required this.user, 
    required this.comment});

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date?.toIso8601String(),
      'user': user,
      'comment': comment,
    };
  }

  // Factory constructor for JSON deserialization
  factory EventMemberCommentModel.fromJson(Map<String, dynamic> data) {
    return EventMemberCommentModel(
      id: data['id'] as int,
      date: data['date'] != null ? DateTime.tryParse(data['date']) : null,
      user: data['user'] as String,
      comment: data['comment'] as String,
    );
  }
}
