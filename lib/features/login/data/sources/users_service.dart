import 'package:fempinya3_flutter_app/features/login/login.dart';

import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class UsersService {
  Future<Either<String, UserEntity>> getUser(GetUserParams params);
}

class UsersServiceImpl implements UsersService {
  final Dio _dio = sl<Dio>();
  final Logger _logger = sl<Logger>();

  Map<String, dynamic> _buildGetUserQueryParams(GetUserParams params) {
    return {'mail': params.mail, 'password': params.password};
  }

  @override
  Future<Either<String, UserEntity>> getUser(GetUserParams params) async {
    try {
      final response = await _dio.get('/User',
          queryParameters: _buildGetUserQueryParams(params));
      if (response.statusCode == 200 && response.data is String) {
        final json =
            jsonDecode(response.data as String) as Map<String, dynamic>;
        return Right(UserEntity.fromModel(UserModel.fromJson(json)));
      }
      return const Left('Unexpected response format');
    } catch (e, stacktrace) {
      _logError('Error when calling get /User endpoint', e, stacktrace);
      return Left('Error when calling get /User endpoint: $e');
    }
  }

  void _logError(String message, dynamic error, StackTrace stacktrace) {
    _logger.e(message, error, stacktrace);
  }
}
