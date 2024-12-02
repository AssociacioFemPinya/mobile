import 'package:formz/formz.dart';

enum MailValidationError { empty, invalid }

class Mail extends FormzInput<String, MailValidationError> {
  const Mail.pure() : super.pure('');
  const Mail.dirty([super.value = '']) : super.dirty();

  @override
  MailValidationError? validator(String value) {
    if (value.isEmpty) return MailValidationError.empty;
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return MailValidationError.invalid;
    }
    return null;
  }
}
