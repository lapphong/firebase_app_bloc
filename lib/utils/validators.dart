/// Class utilities for handling validators text in String
///
/// **Features**:
/// - Get regex
/// - Check is valid text or not
///
class Validators {
  // Regexs Validators

  /// Email Validation Regex
  static final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  /// Phone with country code validation regex
  static final RegExp phoneRegExp = RegExp(
      r'''(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|
2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|
4[987654310]|3[9643210]|2[70]|7|1)\d{6,14}$''');

  // Main function validation text

  /// Method to check email text is valid or not
  ///
  /// When valid is email address then return `true`
  /// Otherwise return `false`
  static bool isValidEmail(String data) {
    return emailRegExp.hasMatch(data);
  }

  /// Method to check phone number text is valid or not
  ///
  /// When valid is phone number then return `true`
  /// Otherwise return `false`
  static bool isValidPhone(String data) {
    return phoneRegExp.hasMatch(data);
  }

  /// Method to cek is valid text with minimum length
  ///
  /// Text when
  ///
  /// Params [trim] can trim text, this method simillar in String `.trim()`
  ///
  /// When valid is text meet the rules with minimum length then return `true`
  /// Otherwise return `false`
  static bool isValidWithMinimumLength(String data, int minimumLength,
      {bool trim = true}) {
    return (trim ? data.trim() : data).length >= minimumLength;
  }
}
