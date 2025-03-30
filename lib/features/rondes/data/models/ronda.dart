class RondaModel {
  final int? id;
  final String? publicUrl;
  final int? ronda;
  final String? name;

  RondaModel(
      {required this.id,
      required this.publicUrl,
      required this.ronda,
      required this.name});

  // Factory constructor for JSON deserialization
  factory RondaModel.fromJson(Map<String, dynamic> data) {
    return RondaModel(
      id: data['id'],
      publicUrl: data['publicUrl'],
      ronda: data['ronda'],
      name: data['name'],
    );
  }

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'publicUrl': publicUrl,
      'ronda': ronda,
      'name': name,
    };
  }
}
