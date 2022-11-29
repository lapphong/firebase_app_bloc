import 'package:formz/formz.dart';

import '../validators.dart';

enum EmailValidationError { empty, invalid }

class EmailFormz extends FormzInput<String, EmailValidationError> {
  const EmailFormz.pure() : super.pure('');

  const EmailFormz.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    if (value?.isEmpty ?? false) {
      return EmailValidationError.empty;
    }

    return Validators.isValidEmail(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}
