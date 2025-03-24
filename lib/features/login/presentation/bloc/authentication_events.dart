part of 'authentication_bloc.dart';

sealed class AuthenticationEvents extends Equatable {
  const AuthenticationEvents();

  @override
  List<Object> get props => [];
}

final class AuthenticationSubscriptionRequested extends AuthenticationEvents {}

final class AuthenticationLogoutPressed extends AuthenticationEvents {}
