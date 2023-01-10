part of 'like_course_cubit.dart';

enum LikeCourseStatus { like, unlike }

class LikeCourseState extends Equatable {
  final LikeCourseStatus status;
  final CustomError error;

  const LikeCourseState({
    required this.status,
    required this.error,
  });

  factory LikeCourseState.initial() {
    return const LikeCourseState(
      status: LikeCourseStatus.unlike,
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, error];

  LikeCourseState copyWith({
    LikeCourseStatus? status,
    CustomError? error,
  }) {
    return LikeCourseState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
