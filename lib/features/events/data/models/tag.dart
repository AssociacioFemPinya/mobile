class TagModel {
  final int id;
  final String name;
  final bool isEnabled;

  TagModel({required this.id, required this.name, required this.isEnabled});

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isEnabled': isEnabled,
    };
  }

  // Factory constructor for JSON deserialization
  factory TagModel.fromJson(Map<String, dynamic> data) {
    return TagModel(
      id: data['id'] as int,
      name: data['name'] ?? '',
      isEnabled: data['isEnabled'] ?? false,
    );
  }
}
