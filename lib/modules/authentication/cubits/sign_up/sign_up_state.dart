part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.name = const Name.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.check = false,
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final Name name;
  final ConfirmedPassword confirmedPassword;
  final bool check;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        email,
        password,
        name,
        confirmedPassword,
        check,
        status,
        errorMessage,
      ];

  SignUpState copyWith({
    Email? email,
    Password? password,
    Name? name,
    ConfirmedPassword? confirmedPassword,
    bool? check,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      check: check ?? this.check,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
