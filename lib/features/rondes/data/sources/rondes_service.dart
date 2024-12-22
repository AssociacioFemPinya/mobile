import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

abstract class RondesService {
  Future<Either<String, List<RondaEntity>>> getRondesList(
      GetRondesListParams params);
  Future<Either<String, RondaEntity>> getRonda(GetRondaParams params);
}

class RondesServiceImpl implements RondesService {
  final Dio _dio = sl<Dio>();
  final Logger _logger = sl<Logger>();

  @override
  Future<Either<String, List<RondaEntity>>> getRondesList(
      GetRondesListParams params) async {
    try {
      final response = await _dio.get('/rondes',
          queryParameters: _buildGetRondesListQueryParams(params));
      if (response.statusCode == 200 && response.data is String) {
        final jsonList = jsonDecode(response.data as String) as List<dynamic>;
        final pinyes = jsonList
            .map((json) => RondaEntity.fromModel(RondaModel.fromJson(json)))
            .toList();
        return Right(pinyes);
      } else if (response.statusCode == 500) {
        return Left('Any user email provided');
      }
      return const Left('Unexpected response format');
    } catch (e, stacktrace) {
      _logError('Error when calling /rondes endpoint', e, stacktrace);
      return Left('Error when calling /rondes endpoint: $e');
    }
  }

  Map<String, dynamic> _buildGetRondesListQueryParams(
      GetRondesListParams params) {
    return {'email': params.email};
  }

  void _logError(String message, dynamic error, StackTrace stacktrace) {
    _logger.e(message, error, stacktrace);
  }

  @override
  Future<Either<String, RondaEntity>> getRonda(GetRondaParams params) async {
    try {
      final response = await _dio.get('/ronda',
          queryParameters: _buildGetRondaQueryParams(params));
      if (response.statusCode == 200 && response.data is String) {
        final json =
            jsonDecode(response.data as String) as Map<String, dynamic>;
        return Right(RondaEntity.fromModel(RondaModel.fromJson(json)));
      } else if (response.statusCode == 404) {
        return Left('Unknown ronda id');
      } else if (response.statusCode == 500) {
        return Left('Any ronda id provided');
      }
      return const Left('Unexpected response format');
    } catch (e, stacktrace) {
      _logError('Error when calling /ronda endpoint', e, stacktrace);
      return Left('Error when calling /ronda endpoint: $e');
    }
  }

  _buildGetRondaQueryParams(GetRondaParams params) {
    return {'id': params.id};
  }
}
