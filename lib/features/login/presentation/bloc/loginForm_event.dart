part of 'loginForm_bloc.dart';

sealed class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

class LoginMailChanged extends LoginFormEvent {
  final String mail;
  const LoginMailChanged(this.mail);

  @override
  List<Object> get props => [mail];
}

class LoginPasswordChanged extends LoginFormEvent {
  final String password;
  const LoginPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginFormEvent {
  const LoginSubmitted();
}

class LoginResetStatus extends LoginFormEvent {
  const LoginResetStatus();
}
