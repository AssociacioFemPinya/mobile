import 'package:equatable/equatable.dart';


class EventEntity extends Equatable {
  final int? id;
  final String? title;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? address;

  const EventEntity(
      {this.id, this.title, this.startDate, this.endDate, this.address});

  @override
  List<Object?> get props {
    return [id, title, startDate, endDate, address];
  }
}
