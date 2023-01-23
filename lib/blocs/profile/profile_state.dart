part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final ProfileStatus profileStatus;
  final User user;
  final List<MyLearning> listMyLearning;
  final CustomError error;

  const ProfileState({
    required this.profileStatus,
    required this.user,
    required this.listMyLearning,
    required this.error,
  });

  factory ProfileState.initial() {
    return ProfileState(
      profileStatus: ProfileStatus.initial,
      user: User.initialUser(),
      listMyLearning: const [],
      error: const CustomError(),
    );
  }

  @override
  List<Object> get props => [profileStatus, user, listMyLearning, error];

  @override
  String toString() =>
      'ProfileState(profileStatus: $profileStatus,user: $user,listMyLearning:$listMyLearning,error: $error)';

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    User? user,
    List<MyLearning>? listMyLearning,
    CustomError? error,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
      listMyLearning: listMyLearning ?? this.listMyLearning,
      error: error ?? this.error,
    );
  }
}
