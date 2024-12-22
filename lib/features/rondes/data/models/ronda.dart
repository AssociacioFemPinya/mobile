class RondaModel {
  final int? id;
  final String? publicUrl;
  final int? ronda;
  final String? eventName;

  RondaModel(
      {required this.id,
      required this.publicUrl,
      required this.ronda,
      required this.eventName});

  // Factory constructor for JSON deserialization
  factory RondaModel.fromJson(Map<String, dynamic> data) {
    return RondaModel(
      id: data['id'],
      publicUrl: data['publicUrl'],
      ronda: data['ronda'],
      eventName: data['eventName'],
    );
  }

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'publicUrl': publicUrl,
      'ronda': ronda,
      'eventName': eventName,
    };
  }
}
