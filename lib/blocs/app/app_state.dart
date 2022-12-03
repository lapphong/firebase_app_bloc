part of 'app_bloc.dart';

enum AppStatus { unknown, authenticated, unauthenticated }

class AppState extends Equatable {
  final AppStatus appStatus;
  final auth.User? user;
  const AppState({
    required this.appStatus,
    this.user,
  });

  factory AppState.unknown() {
    return const AppState(appStatus: AppStatus.unknown);
  }

  @override
  List<Object?> get props => [appStatus, user];

  @override
  String toString() => 'AppState(authStatus: $appStatus,user: $user)';

  AppState copyWith({
    AppStatus? appStatus,
    auth.User? user,
  }) {
    return AppState(
      appStatus: appStatus ?? this.appStatus,
      user: user ?? this.user,
    );
  }
}
