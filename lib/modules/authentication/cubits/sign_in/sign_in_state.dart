part of 'sign_in_cubit.dart';

// enum SignInStatus {
//   initial,
//   isEmailValid,
//   isPasswordValid,
//   submitting,
//   success,
//   error,
// }

// class SignInState extends Equatable {
//   final SignInStatus signInStatus;
//   final CustomError error;
//   SignInState({
//     required this.signInStatus,
//     required this.error,
//   });

//   factory SignInState.initial() {
//     return SignInState(
//       signInStatus: SignInStatus.initial,
//       error: CustomError(),
//     );
//   }

//   @override
//   List<Object> get props => [signInStatus, error];

//   @override
//   String toString() => 'SignInState(signInStatus:$signInStatus,error: $error)';

//   SignInState copyWith({
//     SignInStatus? signInStatus,
//     CustomError? error,
//   }) {
//     return SignInState(
//       signInStatus: signInStatus ?? this.signInStatus,
//       error: error ?? this.error,
//     );
//   }
// }

class SignInState extends Equatable {
  const SignInState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [email, password, status];

  SignInState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
