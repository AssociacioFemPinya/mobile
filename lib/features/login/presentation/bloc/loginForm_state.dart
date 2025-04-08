part of 'loginForm_bloc.dart';

class LoginFormState extends Equatable {
  const LoginFormState({
    this.status = FormzSubmissionStatus.initial,
    this.mail = const Mail.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Mail mail;
  final Password password;
  final bool isValid;

  LoginFormState copyWith({
    FormzSubmissionStatus? status,
    Mail? mail,
    Password? password,
    bool? isValid,
  }) {
    return LoginFormState(
      status: status ?? this.status,
      mail: mail ?? this.mail,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginFormState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          mail == other.mail &&
          password == other.password &&
          isValid == other.isValid;
          
  @override
  List<Object> get props => [status, mail, password];
}
