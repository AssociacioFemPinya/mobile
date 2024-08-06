import 'package:equatable/equatable.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';

class EventEntity extends Equatable {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String dateHour;
  final String address;
  final EventStatusEnum status;
  final EventTypeEnum type;
  final String description;
  
  const EventEntity(
      {required this.id,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.dateHour,
      required this.address,
      required this.status,
      required this.type,
      required this.description
      });

  @override
  List<Object?> get props {
    return [id, title, startDate, endDate, address];
  }

  factory EventEntity.fromJson(Map<String, dynamic> json) {
    return EventEntity(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      dateHour: json['dateHour'],
      address: json['address'],
      status: EventStatusEnum.values.firstWhere((e) => e.toString() == 'EventStatusEnum.${json['status']}'),
      type: EventTypeEnum.values.firstWhere((e) => e.toString() == 'EventTypeEnum.${json['type']}'),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'dateHour': dateHour,
      'address': address,
      'status': status.toString().split('.').last,
      'type': type.toString().split('.').last,
      'description': description,
    };
  }
}
