part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,
    this.user = UserEntity.empty,
  });

  const AuthenticationState.unknown() : this();

  const AuthenticationState.authenticated(UserEntity user)
      : this(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this(status: AuthenticationStatus.unauthenticated, user: null);

  final AuthenticationStatus status;
  final UserEntity? user;

  @override
  List<Object?> get props => [status, user];
}
