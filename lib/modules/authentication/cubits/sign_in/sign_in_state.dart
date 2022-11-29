part of 'sign_in_cubit.dart';

enum SignInStatus { initial, submitting, success, error }

class SignInState extends Equatable {
  final SignInStatus signInStatus;
  final CustomError error;
  SignInState({
    required this.signInStatus,
    required this.error,
  });

  factory SignInState.initial() {
    return SignInState(
      signInStatus: SignInStatus.initial,
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [signInStatus, error];

  @override
  String toString() => 'SignInState(signInStatus:$signInStatus,error: $error)';

  SignInState copyWith({
    SignInStatus? signInStatus,
    CustomError? error,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      error: error ?? this.error,
    );
  }
}
