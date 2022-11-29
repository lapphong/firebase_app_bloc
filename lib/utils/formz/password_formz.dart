import 'package:formz/formz.dart';

import '../validators.dart';

enum PasswordValidationError { empty, invalid }

class PasswordFormz extends FormzInput<String, PasswordValidationError> {
  const PasswordFormz.pure() : super.pure('');

  const PasswordFormz.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    if (value?.isEmpty ?? false) {
      return PasswordValidationError.empty;
    }

    return Validators.isValidWithMinimumLength(value ?? '', 1)
        ? null
        : PasswordValidationError.invalid;
  }
}
