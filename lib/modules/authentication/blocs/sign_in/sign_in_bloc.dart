import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../repositories/auth_repository.dart';
import '../../../../utils/formz/email_formz.dart';
import '../../../../utils/formz/password_formz.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository repository;

  SignInBloc({required this.repository}) : super(const SignInState()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInSubmitted>(_onSubmitted);
  }

  Future<void> _onEmailChanged(
    SignInEmailChanged event,
    Emitter<SignInState> emit,
  ) async {
    final email = EmailFormz.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  Future<void> _onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) async {
    final password = PasswordFormz.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  Future<void> _onSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await repository.signIn(
          email: state.email.value,
          password: state.password.value,
        );

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on Exception catch (e) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            failure: e.toString(),
          ),
        );
      }
    }
  }
}
