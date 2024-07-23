import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/features/events/data/sources/events_service.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';
import 'dart:math';

import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_events_list.dart';

class EventsServiceMockupImpl implements EventsService {
  late List<EventEntity> eventList;

  EventsServiceMockupImpl() {
    eventList = _generateEvents();
  }

  List<EventEntity> _generateEvents() {
    final random = Random();
    final now = DateTime.now();
    final oneWeekLater = now.add(const Duration(days: 7));

    DateTime _getRandomDateTime() {
      final differenceInMillis =
          oneWeekLater.millisecondsSinceEpoch - now.millisecondsSinceEpoch;
      final randomMillis = random.nextInt(differenceInMillis);
      return now.add(Duration(milliseconds: randomMillis));
    }

    return List<EventEntity>.generate(20, (index) {
      return EventEntity(
          id: index,
          status: EventStatusEnum
              .values[random.nextInt(EventStatusEnum.values.length)],
          title: "EventMockup $index",
          address: "Address $index",
          type:
              EventTypeEnum.values[random.nextInt(EventTypeEnum.values.length)],
          startDate: _getRandomDateTime(),
          endDate: DateTime.parse('2024-07-01 02:00:00.000Z'),
          dateHour: '10:00 AM',
          description:
              'Lorem ipsum dolor sit amet. Sed quisquam minus aut voluptas quibusdam in quia assumenda non consequatur voluptates in consequatur omnis. Qui praesentium officia aut neque neque qui omnis eligendi et eaque ducimus sit molestias harum. A obcaecati labore aut nobis ullam aut sint dolorem.');
    });
  }

  @override
  Future<Either<Object, List<EventEntity>>> getEventsList(
      GetEventsListParams params) async {
    List<EventEntity> events = _filterEvents(
      eventList,
      params.eventTypeFilters,
      params.dayFilter,
      params.showAnswered,
      params.showUndefined,
      params.showWarning,
    );
    return Right(events);
  }

  List<EventEntity> _filterEvents(
    List<EventEntity> eventsList,
    List<EventTypeEnum> eventTypeFilters,
    DateTime? dayFilter,
    bool showAnswered,
    bool showUndefined,
    bool showWarning,
  ) {

    List<EventEntity> events = dayFilter != null
        ? _getEventsByDate(dayFilter, eventsList)
        : eventsList;

    List<EventEntity> filteredEventsByType =
        _filterByType(events, eventTypeFilters);
    return _filterByStatus(
        filteredEventsByType, showAnswered, showUndefined, showWarning);
  }

  List<EventEntity> _filterByType(
    List<EventEntity> eventsList,
    List<EventTypeEnum> eventTypeFilters,
  ) {
    if (eventTypeFilters.isEmpty) {
      return eventsList;
    }

    return eventsList
        .where((event) => eventTypeFilters.contains(event.type))
        .toList();
  }

  List<EventEntity> _filterByStatus(
    List<EventEntity> eventsList,
    bool showAnswered,
    bool showUndefined,
    bool showWarning,
  ) {
    return eventsList.where((event) {
      if (showUndefined && event.status == EventStatusEnum.undefined) {
        return true;
      }
      if (showAnswered &&
          ([
            EventStatusEnum.accepted,
            EventStatusEnum.declined,
            EventStatusEnum.warning,
            EventStatusEnum.unknown
          ].contains(event.status))) {
        return true;
      }
      if (showWarning && event.status == EventStatusEnum.warning) {
        return true;
      }
      return !showUndefined && !showAnswered && !showWarning;
    }).toList();
  }

  List<EventEntity> _getEventsByDate(
      DateTime date, List<EventEntity> eventsList) {
    return eventsList.where((event) => date == DateTime.utc(
            event.startDate.year, event.startDate.month, event.startDate.day)).toList();
  }
}
