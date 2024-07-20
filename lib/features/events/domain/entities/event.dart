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
}
