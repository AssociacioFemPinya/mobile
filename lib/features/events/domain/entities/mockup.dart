import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class EventMockup {
  final EventStatusEnum status;
  final String name;
  final String address;
  final String dateHour;
  final IconData icon;

  EventMockup(
      {required this.status,
      required this.name,
      required this.address,
      required this.dateHour,
      required this.icon});
}

class DateMockup {
  final String date;
  final List<EventMockup> events;

  DateMockup({required this.date, required this.events});
}

List<DateMockup> generateMockup() {
  final names = ['EventMockup 1', 'EventMockup 2', 'EventMockup 3'];
  final addresses = ['Dirección 1', 'Dirección 2', 'Dirección 3'];
  final dateHours = ['10:00 AM', '12:00 PM', '02:00 PM'];
  final icons = [Icons.event, Icons.party_mode, Icons.work];

  final random = Random();

  List<EventMockup> generateEvents() {
    return List<EventMockup>.generate(3, (index) {
      return EventMockup(
        status: EventStatusEnum
            .values[random.nextInt(EventStatusEnum.values.length)],
        name: names[index],
        address: addresses[index],
        dateHour: dateHours[index],
        icon: icons[index],
      );
    });
  }

  return [
    DateMockup(date: '2024-06-01', events: generateEvents()),
    DateMockup(date: '2024-06-02', events: generateEvents()),
    DateMockup(date: '2024-06-03', events: generateEvents()),
  ];
}
