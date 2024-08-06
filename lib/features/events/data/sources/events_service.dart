import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/features/events/data/models/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_events_list.dart';
import 'package:fempinya3_flutter_app/features/events/service_locator.dart';

abstract class EventsService {
  Future<Either<String, List<EventEntity>>> getEventsList(
      GetEventsListParams params);
}

class EventsServiceImpl implements EventsService {
  final Dio _dio = sl<Dio>();

  @override
  Future<Either<String, List<EventEntity>>> getEventsList(
      GetEventsListParams params) async {
    try {
      final response = await _dio.get(
        '/events',
        queryParameters: params.toQueryParams(),
      );

      // Check for successful response status
      if (response.statusCode == 200) {
        if (response.data is String) {
          // Decode the JSON data
          final jsonList = jsonDecode(response.data as String) as List<dynamic>;

          // Convert each JSON object to EventModel and then to EventEntity
          final events = jsonList
              .map((json) => EventModel.fromJson(json))
              .map((model) => EventEntity.fromModel(model))
              .toList();

          return Right(events);
        } else {
          return const Left('Unexpected response format');
        }
      } else {
        // Handle different status codes
        return Left('Error: Received status code ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error when calling /events endpoint: $e');
    }
  }
}
