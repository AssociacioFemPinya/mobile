import 'package:dartz/dartz.dart';
import 'package:fempinya3_flutter_app/features/login/login.dart';

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationResult {
  final AuthenticationStatus status;
  final UserEntity? userEntity;

  AuthenticationResult({required this.status, this.userEntity});
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationResult>();

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
        await fetchAndHandleUserData(mail, password);
      },
    );
  }

  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> fetchAndHandleUserData(String mail, String password) async {
    final getUserParams = GetUserParams(mail: mail, password: password);
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');

    _controller.add(
        AuthenticationResult(status: AuthenticationStatus.unauthenticated));
  }

  void dispose() => _controller.close();
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}
