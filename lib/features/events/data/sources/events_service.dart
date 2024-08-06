import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_events_list.dart';
import 'package:fempinya3_flutter_app/features/events/service_locator.dart';

abstract class EventsService {
  Future<Either<String, List<EventEntity>>> getEventsList(GetEventsListParams params);
}

class EventsServiceImpl implements EventsService {

  @override
  Future<Either<String, List<EventEntity>>> getEventsList(GetEventsListParams params) async {
    final Dio dio = sl<Dio>();

    try {
      final response = await dio.get(
        '/events',
        queryParameters: params.toQueryParams(),
      );

      // Check if response data is a String and decode it
      if (response.data is String) {
        String jsonString = response.data as String;
        List<dynamic> jsonList = jsonDecode(jsonString);
        List<EventEntity> events = jsonList.map((json) => EventEntity.fromJson(json)).toList();
        return Right(events);
      } else {
        return const Left('Unexpected response format');
      }
    } catch (e) {
      return Left('Error when calling /events endpoint: $e');
    }
  }
}
