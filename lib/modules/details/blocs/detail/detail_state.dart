part of 'detail_bloc.dart';

enum DetailStatus { initial, loading, loaded, error }

class DetailState extends Equatable {
  final DetailStatus status;
  final Teacher teacher;
  final CustomError error;

  const DetailState({
    required this.status,
    required this.teacher,
    required this.error,
  });

  factory DetailState.initial() {
    return DetailState(
      status: DetailStatus.initial,
      teacher: Teacher.initialTeacher(),
      error: const CustomError(),
    );
  }

  @override
  List<Object> get props => [status, teacher, error];

  @override
  String toString() =>
      'DetailState(status: $status, teacher: $teacher, error: $error)';

  DetailState copyWith({
    DetailStatus? status,
    Teacher? teacher,
    CustomError? error,
  }) {
    return DetailState(
      status: status ?? this.status,
      teacher: teacher ?? this.teacher,
      error: error ?? this.error,
    );
  }
}
