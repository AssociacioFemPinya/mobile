class PublicDisplayUrlModel {
  final String? publicUrl;

  PublicDisplayUrlModel({
    required this.publicUrl,
  });

  // Factory constructor for JSON deserialization
  factory PublicDisplayUrlModel.fromJson(Map<String, dynamic> data) {
    return PublicDisplayUrlModel(
      publicUrl: data['publicUrl'],
    );
  }

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'publicUrl': publicUrl,
    };
  }
}
