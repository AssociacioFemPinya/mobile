class EventModel {
  final int? id;
  final String? title;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? address;
  final String? status;
  final String? type;

  EventModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.address,
    required this.status,
    required this.type,
  });

  // Factory constructor for JSON deserialization
  factory EventModel.fromJson(Map<String, dynamic> data) {
    return EventModel(
      id: data['id'],
      title: data['title'],
      startDate: DateTime.tryParse(data['startDate'] ?? ''),
      endDate: DateTime.tryParse(data['endDate'] ?? ''),
      address: data['address'],
      status: data['status'],
      type: data['type'],
    );
  }

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'address': address,
      'status': status,
      'type': type,
    };
  }
}
