class EventMemberCommentModel {
  final String name;

  EventMemberCommentModel({required this.name});

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  // Factory constructor for JSON deserialization
  factory EventMemberCommentModel.fromJson(Map<String, dynamic> data) {
    return EventMemberCommentModel(
      name: data['name'] as String,
    );
  }
}
