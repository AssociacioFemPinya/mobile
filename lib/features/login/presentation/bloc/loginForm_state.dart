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
  List<Object> get props => [status, mail, password];
}
