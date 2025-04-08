import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fempinya3_flutter_app/features/login/login.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationResult {
  final AuthenticationStatus status;
  final UserEntity? userEntity;

  AuthenticationResult({required this.status, this.userEntity});

  @override
  String toString() {
    return 'AuthenticationResult($status, userEntity: "$userEntity")';
  }

  // Override the equality operator to compare two AuthenticationResult objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationResult &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          userEntity == other.userEntity;

  @override
  int get hashCode => status.hashCode ^ userEntity.hashCode;
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationResult>();
  final SharedPreferences sharedPreferences;

  AuthenticationRepository(this.sharedPreferences);

  Stream<AuthenticationResult> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    // yield AuthenticationStatus.unauthenticated;
    yield AuthenticationResult(status: AuthenticationStatus.unauthenticated);
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String mail,
    required String password,
  }) async {
    GetTokenParams getTokenParams =
        GetTokenParams(mail: mail, password: password);

    var tokenResult = await sl<GetToken>().call(params: getTokenParams);

    await handleGetTokenResult(tokenResult, mail, password);
  }

  Future<void> handleGetTokenResult(
      Either<dynamic, dynamic> result, String mail, String password) async {
    await result.fold(
      (failure) async {
        _controller.add(
            AuthenticationResult(status: AuthenticationStatus.unauthenticated));
        throw AuthenticationException('Invalid username or password');
      },
      (data) async {
        await saveAuthToken(data.access_token);
        await fetchAndHandleUserData();
      },
    );
  }

  Future<void> saveAuthToken(String token) async {
    await sharedPreferences.setString('auth_token', token);
  }

  Future<void> fetchAndHandleUserData() async {
    final getUserParams = GetUserParams();
    final result = await sl<GetUser>().call(params: getUserParams);

    await result.fold(
      (failure) async {
        _controller.add(
            AuthenticationResult(status: AuthenticationStatus.unauthenticated));
        throw AuthenticationException('Invalid token');
      },
      (userData) {
        _controller.add(AuthenticationResult(
          status: AuthenticationStatus.authenticated,
          userEntity: userData,
        ));
      },
    );
  }

  Future<void> logOut() async {
    await sharedPreferences.remove('auth_token');
  }

  void dispose() => _controller.close();
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}
