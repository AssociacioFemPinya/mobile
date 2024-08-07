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
}

class EventsServiceImpl implements EventsService {
  final Dio _dio = sl<Dio>();

  Map<String, dynamic> _buildGetEventsListQueryParams(GetEventsListParams params) {
    final Map<String, dynamic> queryParams = {};

    if (params.eventTypeFilters.isNotEmpty) {
      queryParams['eventTypeFilters'] = params.eventTypeFilters.map((e) => e.toString().split('.').last).toList();
    }
    if (params.dayTimeRange != null) {
      queryParams['startDate'] = DateFormat('yyyy-MM-dd').format(params.dayTimeRange!.start);
      queryParams['endDate'] = DateFormat('yyyy-MM-dd').format(params.dayTimeRange!.end);
    }
    queryParams['showAnswered'] = params.showAnswered;
    queryParams['showUndefined'] = params.showUndefined;
    queryParams['showWarning'] = params.showWarning;

    return queryParams;
  }

  @override
  Future<Either<String, List<EventEntity>>> getEventsList(
      GetEventsListParams params) async {
    try {
      final response =
          await _dio.get('/events', queryParameters: _buildGetEventsListQueryParams(params));
      if (response.statusCode == 200 && response.data is String) {
        final jsonList = jsonDecode(response.data as String) as List<dynamic>;
        final events = jsonList
            .map((json) => EventEntity.fromModel(EventModel.fromJson(json)))
            .toList();
        return Right(events);
      }
      return const Left('Unexpected response format');
    } catch (e) {
      return Left('Error when calling /events endpoint: $e');
    }
  }
}