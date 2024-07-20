import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/features/events/data/sources/events_service.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';

import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'dart:math';

import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';

class EventsServiceMockupImpl implements EventsService {
  late List<EventEntity> eventList;

  EventsServiceMockupImpl() {
    final random = Random();
    final now = DateTime.now();
    final oneWeekLater = now.add(const Duration(days: 7));

    DateTime getRandomDateTime() {
      final differenceInMillis =
          oneWeekLater.millisecondsSinceEpoch - now.millisecondsSinceEpoch;
      final randomMillis = random.nextInt(differenceInMillis);
      final randomDateTime = now.add(Duration(milliseconds: randomMillis));

      return randomDateTime;
    }

    List<EventEntity> generateEvents() {
      return List<EventEntity>.generate(20, (index) {
        return EventEntity(
          id: index,
          status: EventStatusEnum
              .values[random.nextInt(EventStatusEnum.values.length)],
          title: "EventMockup $index",
          address: "Address $index",
          type:
              EventTypeEnum.values[random.nextInt(EventTypeEnum.values.length)],
          startDate: getRandomDateTime(),
          endDate: DateTime.parse('2024-07-01 02:00:00.000Z'),
          dateHour: '10:00 AM',
        );
      });
    }

    eventList = generateEvents();
  }

  Future<Either> getEventsList() async {
    return Right(eventList);
  }
}
