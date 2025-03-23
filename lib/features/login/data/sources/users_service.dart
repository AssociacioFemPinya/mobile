import 'package:fempinya3_flutter_app/features/login/login.dart';

import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class UsersService {
  Future<Either<String, UserEntity>> getUser(GetUserParams params);
  Future<Either<String, TokenEntity>> getToken(GetTokenParams params);
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

  Map<String, dynamic> _buildGetTokenQueryParams(GetTokenParams params) {
    return {'email': params.mail, 'password': params.password};
  }

  @override
  Future<Either<String, TokenEntity>> getToken(GetTokenParams params) async {
    try {
      final response = await _dio.post('/api/auth/login',
          queryParameters: _buildGetTokenQueryParams(params));
      if (response.statusCode == 200 && response.data is Map) {
        final json = response.data as Map<String, dynamic>;
        return Right(TokenEntity.fromModel(TokenModel.fromJson(json)));
      }
      return const Left('Unexpected response format');
    } catch (e, stacktrace) {
      _logError(
          'Error when calling get /api/auth/login endpoint', e, stacktrace);
      return Left('Error when calling get /api/auth/login endpoint: $e');
    }
  }

  void _logError(String message, dynamic error, StackTrace stacktrace) {
    _logger.e(message, error, stacktrace);
  }
}
