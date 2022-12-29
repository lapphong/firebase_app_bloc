part of 'detail_bloc.dart';

enum OverviewStatus { initial, loading, loaded, error }

enum CourseStatus { initial, loading, loaded, error }

class DetailState extends Equatable {
  final OverviewStatus statusOverview;
  final CourseStatus statusCourse;
  final Teacher teacher;
  final List<VideoCourse> videoCourse;
  final CustomError error;

  const DetailState({
    required this.statusOverview,
    required this.statusCourse,
    required this.teacher,
    required this.videoCourse,
    required this.error,
  });

  factory DetailState.initial() {
    return DetailState(
      statusOverview: OverviewStatus.initial,
      statusCourse: CourseStatus.initial,
      teacher: Teacher.initialTeacher(),
      videoCourse: const [],
      error: const CustomError(),
    );
  }

  @override
  List<Object> get props => [
        statusOverview,
        statusCourse,
        teacher,
        videoCourse,
        error,
      ];

  @override
  String toString() =>
      'DetailState(statusOverview: $statusOverview,statusCourse: $statusCourse, teacher: $teacher,videoCourse: $videoCourse, error: $error)';

  DetailState copyWith({
    OverviewStatus? statusOverview,
    CourseStatus? statusCourse,
    Teacher? teacher,
    List<VideoCourse>? videoCourse,
    CustomError? error,
  }) {
    return DetailState(
      statusOverview: statusOverview ?? this.statusOverview,
      statusCourse: statusCourse ?? this.statusCourse,
      teacher: teacher ?? this.teacher,
      videoCourse: videoCourse ?? this.videoCourse,
      error: error ?? this.error,
    );
  }
}
