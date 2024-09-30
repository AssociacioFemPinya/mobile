import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_event.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/features/events/data/models/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/useCases/get_events_list.dart';
import 'package:fempinya3_flutter_app/features/events/service_locator.dart';
import 'package:intl/intl.dart';

abstract class EventsService {
  Future<Either<String, List<EventEntity>>> getEventsList(
      GetEventsListParams params);
  Future<Either<String, EventEntity>> getEvent(GetEventParams params);
  Future<Either<String, EventEntity>> postEvent(EventEntity params);
}

class EventsServiceImpl implements EventsService {
  final Dio _dio = sl<Dio>();
  final Logger _logger = sl<Logger>();

  Map<String, dynamic> _buildGetEventsListQueryParams(
      GetEventsListParams params) {
    return {
      if (params.eventTypeFilters.isNotEmpty)
        'eventTypeFilters': params.eventTypeFilters
            .map((e) => e.toString().split('.').last)
            .toList(),
      if (params.dayTimeRange != null) ...{
        'startDate':
            DateFormat('yyyy-MM-dd').format(params.dayTimeRange!.start),
        'endDate': DateFormat('yyyy-MM-dd').format(params.dayTimeRange!.end),
      },
      'showAnswered': params.showAnswered,
      'showUndefined': params.showUndefined,
      'showWarning': params.showWarning,
    };
  }

  @override
  Future<Either<String, List<EventEntity>>> getEventsList(
      GetEventsListParams params) async {
    try {
      final response = await _dio.get('/events',
          queryParameters: _buildGetEventsListQueryParams(params));
      if (response.statusCode == 200 && response.data is String) {
        final jsonList = jsonDecode(response.data as String) as List<dynamic>;
        final events = jsonList
            .map((json) => EventEntity.fromModel(EventModel.fromJson(json)))
            .toList();
        return Right(events);
      }
      return const Left('Unexpected response format');
    } catch (e, stacktrace) {
      _logError('Error when calling /events endpoint', e, stacktrace);
      return Left('Error when calling /events endpoint: $e');
    }
  }

  Map<String, dynamic> _buildGetEventQueryParams(GetEventParams params) {
    return {'id': params.id};
  }

  @override
  Future<Either<String, EventEntity>> getEvent(GetEventParams params) async {
    try {
      final response = await _dio.get('/event',
          queryParameters: _buildGetEventQueryParams(params));
      if (response.statusCode == 200 && response.data is String) {
        final json = jsonDecode(response.data as String) as Map<String, dynamic>;
        return Right(EventEntity.fromModel(EventModel.fromJson(json)));
      }
      return const Left('Unexpected response format');
    } catch (e, stacktrace) {
      _logError('Error when calling get /event endpoint', e, stacktrace);
      return Left('Error when calling get /event endpoint: $e');
    }
  }

  @override
  Future<Either<String, EventEntity>> postEvent(EventEntity params) async {
    try {
      final response = await _dio.post('/event',
          data: jsonEncode(params.toModel().toJson()));
      if (response.statusCode == 200 && response.data is String) {
        final json = jsonDecode(response.data as String) as Map<String, dynamic>;
        return Right(EventEntity.fromModel(EventModel.fromJson(json)));
      }
      return const Left('Unexpected response format');
    } catch (e, stacktrace) {
      _logError('Error when calling post /event endpoint', e, stacktrace);
      return Left('Error when calling post /event endpoint: $e');
    }
  }

  void _logError(String message, dynamic error, StackTrace stacktrace) {
    _logger.e(message, error, stacktrace);
  }
}
