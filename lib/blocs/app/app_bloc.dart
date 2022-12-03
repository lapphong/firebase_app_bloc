import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../repositories/auth_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late final StreamSubscription authSubscription;
  final AuthRepository authRepository;
  AppBloc({required this.authRepository}) : super(AppState.unknown()) {
    authSubscription = authRepository.user.listen((auth.User? user) {
      add(AppStateChangedEvent(user: user));
    });
    on<AppStateChangedEvent>((event, emit) {
      if (event.user != null) {
        emit(state.copyWith(
          appStatus: AppStatus.authenticated,
          user: event.user,
        ));
      } else {
        emit(state.copyWith(
          appStatus: AppStatus.unauthenticated,
          user: null,
        ));
      }
    });
    on<SignOutEvent>((event, emit) async {
      await authRepository.signOut();
    });
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
