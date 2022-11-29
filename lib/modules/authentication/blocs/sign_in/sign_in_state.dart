part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    this.email = const EmailFormz.pure(),
    this.password = const PasswordFormz.pure(),
    this.status = FormzStatus.pure,
    this.failure,
  });

  final EmailFormz email;
  final PasswordFormz password;
  final FormzStatus status;
  final String? failure;

  @override
  List<Object> get props => [email, password, status];

  SignInState copyWith({
    EmailFormz? email,
    PasswordFormz? password,
    FormzStatus? status,
    String? failure,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
