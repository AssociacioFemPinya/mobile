import 'package:equatable/equatable.dart';
import 'package:fempinya3_flutter_app/features/events/data/models/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';
import 'package:intl/intl.dart';

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

  const EventEntity({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.dateHour,
    required this.address,
    required this.status,
    required this.type,
    required this.description,
  });

  @override
  List<Object?> get props {
    return [id, title, startDate, endDate, address];
  }

  // Factory constructor to create an EventEntity from EventModel
  factory EventEntity.fromModel(EventModel model) {
    return EventEntity(
      // TODO: How to handle properly when data from API in the model in incomplete?
      id: model.id ?? 0,
      title: model.title ?? '',
      startDate: model.startDate ?? DateTime.now(),
      endDate: model.endDate ?? DateTime.now(),
      dateHour: DateFormat('h:mm a').format(model.startDate ?? DateTime.now()), // Populate as needed
      address: model.address ?? '',
      status: EventStatusEnumExtension.fromString(model.status ?? ""),
      type: EventTypeEnumExtension.fromString(model.type ?? ""),
      
      description: '', // Populate as needed
    );
  }

  // Convert the entity to EventModel
  EventModel toModel() {
    return EventModel(
      id: id,
      title: title,
      startDate: startDate,
      endDate: endDate,
      address: address,
      status: status.toString().split('.').last,
      type: type.toString().split('.').last,
    );
  }
}
