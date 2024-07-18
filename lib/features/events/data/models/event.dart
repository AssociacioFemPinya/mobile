class EventModel {
  final int? id;
  final String? title;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? address;
  final String? status;
  final String? type;

  EventModel(
      {required this.id,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.address,
      required this.status,
      required this.type});

  // Secondary constructor for JSON deserialization
  factory EventModel.fromJson(Map<String, dynamic> data) {
    return EventModel(
      id: data['id'],
      title: data['title'],
      startDate: DateTime.parse(data['startDate']),
      endDate: DateTime.parse(data['endDate']),
      address: data['address'],
      status: data['status'],
      type: data['type'],
    );
  }
}
