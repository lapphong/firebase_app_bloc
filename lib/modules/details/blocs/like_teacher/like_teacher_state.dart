part of 'like_teacher_cubit.dart';

enum LikeTeacherStatus { like, unlike }

class LikeTeacherState extends Equatable {
  final LikeTeacherStatus status;
  final CustomError error;

  const LikeTeacherState({
    required this.status,
    required this.error,
  });

  factory LikeTeacherState.initial() {
    return const LikeTeacherState(
      status: LikeTeacherStatus.unlike,
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, error];

  @override
  String toString() => 'LikeState(status: $status,error: $error)';

  LikeTeacherState copyWith({
    LikeTeacherStatus? status,
    CustomError? error,
  }) {
    return LikeTeacherState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
