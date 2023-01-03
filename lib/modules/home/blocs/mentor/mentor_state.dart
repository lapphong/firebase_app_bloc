part of 'mentor_bloc.dart';

enum MentorStatus { initial, loading, loaded, error }

class MentorState extends Equatable {
  final MentorStatus status;
  final List<Teacher> list;
  final CustomError error;
  final bool hasReachedMax;

  const MentorState({
    required this.status,
    required this.list,
    required this.error,
    required this.hasReachedMax,
  });

  factory MentorState.initial() {
    return const MentorState(
      status: MentorStatus.initial,
      list: [],
      error: CustomError(),
      hasReachedMax: false,
    );
  }

  @override
  List<Object> get props => [status, list, error, hasReachedMax];

  @override
  String toString() =>
      'MentorState(status: $status, list: $list, error: $error,hasReachedMax: $hasReachedMax)';

  MentorState copyWith({
    MentorStatus? status,
    List<Teacher>? list,
    CustomError? error,
    bool? hasReachedMax,
  }) {
    return MentorState(
      status: status ?? this.status,
      list: list ?? this.list,
      error: error ?? this.error,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
