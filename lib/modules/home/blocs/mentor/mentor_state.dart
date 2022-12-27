part of 'mentor_bloc.dart';

enum MentorStatus { initial, loading, loaded, error }

class MentorState extends Equatable {
  final MentorStatus status;
  final List<Teacher> list;
  final CustomError error;

  const MentorState({
    required this.status,
    required this.list,
    required this.error,
  });

  factory MentorState.initial() {
    return const MentorState(
      status: MentorStatus.initial,
      list: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, list, error];

  @override
  String toString() =>
      'MentorState(status: $status, list: $list, error: $error)';

  MentorState copyWith({
    MentorStatus? status,
    List<Teacher>? list,
    CustomError? error,
  }) {
    return MentorState(
      status: status ?? this.status,
      list: list ?? this.list,
      error: error ?? this.error,
    );
  }
}
