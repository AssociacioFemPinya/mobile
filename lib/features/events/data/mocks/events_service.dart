// lib/core/network/mock_interceptor.dart
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/core/utils/datetime_utils.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';

class EventsDioMockInterceptor extends Interceptor {
  late List<EventEntity> eventList;

  EventsDioMockInterceptor() {
    eventList = _generateEvents();
  }

  List<EventEntity> _generateEvents() {
    final random = Random();
    final now = DateTime.now();
    final oneWeekLater = now.add(const Duration(days: 7));

    DateTime getRandomDateTime() {
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
          startDate: getRandomDateTime(),
          endDate: DateTime.parse('2024-07-01 02:00:00.000Z'),
          dateHour: '10:00 AM',
          description:
              'Lorem ipsum dolor sit amet. Sed quisquam minus aut voluptas quibusdam in quia assumenda non consequatur voluptates in consequatur omnis. Qui praesentium officia aut neque neque qui omnis eligendi et eaque ducimus sit molestias harum. A obcaecati labore aut nobis ullam aut sint dolorem.');
    });
  }

  List<EventEntity> _filterEvents(
    List<EventTypeEnum> eventTypeFilters,
    final DateTimeRange? dayTimeRange,
    bool showAnswered,
    bool showUndefined,
    bool showWarning,
  ) {
    List<EventEntity> events = dayTimeRange != null
        ? _getEventsByDateRange(dayTimeRange, eventList)
        : eventList;

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

  List<EventEntity> _getEventsByDateRange(
      DateTimeRange dateRange, List<EventEntity> eventsList) {
    return eventsList.where((event) {
      DateTime eventDate = DateTime.utc(
          event.startDate.year, event.startDate.month, event.startDate.day);
      return eventDate.isAfter(dateRange.start) &&
              eventDate.isBefore(dateRange.end) ||
          eventDate.isAtSameMomentAs(dateRange.start) ||
          eventDate.isAtSameMomentAs(dateRange.end);
    }).toList();
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Sleep between 0 and 1 seconds to simulate a slow API
    final random = Random();
    final randomDuration =
        Duration(seconds: random.nextInt(2));
    await Future.delayed(randomDuration);

    // Check the request path and provide a mock response
    if (options.path == '/events') {
      handleEventsCall(options, handler);
    } else {
      // Forward the request if not mocking
      handler.next(options);
    }
  }

  void handleEventsCall(
      RequestOptions options, RequestInterceptorHandler handler) {
    final queryParams = options.queryParameters;
    List<String> eventTypeFilters = queryParams["eventTypeFilters"] ?? [];

    DateTimeRange? dayTimeRange;
    if (queryParams['startDate'] != null) {
      dayTimeRange = DateTimeRange.generateDateTimeRangeForDay(
          DateTime.parse(queryParams['startDate']));
    } else {
      dayTimeRange = null;
    }

    final List<EventEntity> events = _filterEvents(
        eventTypeFilters
            .map((eventTypeFilter) =>
                EventTypeEnumExtension.fromString(eventTypeFilter))
            .toList(),
        dayTimeRange,
        queryParams["showAnswered"],
        queryParams["showUndefined"],
        queryParams["showWarning"]);

    // Sleep between 0 and 2 seconds to simulate a slow API
    final random = Random();
    Response<dynamic> response;

    // One of each 10 requests will "fail" with a 500
    if (random.nextInt(11) > 9) {
      response = Response(
        requestOptions: options,
        statusCode: 500,
      );
    } else {
      // Create a response object
      response = Response(
        requestOptions: options,
        data: jsonEncode(
            events.map((event) => event.toModel().toJson()).toList()),
        statusCode: 200,
      );
    }
    // Complete the request with the mock response
    handler.resolve(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Handle errors if needed
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Handle responses if needed
    super.onResponse(response, handler);
  }
}
