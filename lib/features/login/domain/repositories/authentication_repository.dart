import 'package:fempinya3_flutter_app/features/login/login.dart';

import 'dart:async';

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
    GetUserParams getUserParams = GetUserParams(mail: mail, password: password);
    var result = await sl<GetUser>().call(params: getUserParams);

    result.fold((failure) {
      _controller.add(
          AuthenticationResult(status: AuthenticationStatus.unauthenticated));

      throw AuthenticationException('Invalid username or password');
    }, (data) {
      _controller.add(AuthenticationResult(
          status: AuthenticationStatus.authenticated, userEntity: data));
    });
  }

  void logOut() {
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
