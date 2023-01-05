part of 'like_cubit.dart';

enum Status { like, unlike }

class LikeState extends Equatable {
  final Status status;
  final CustomError error;

  const LikeState({
    required this.status,
    required this.error,
  });

  factory LikeState.initial() {
    return const LikeState(status: Status.unlike, error: CustomError());
  }

  @override
  List<Object> get props => [status, error];

  @override
  String toString() => 'LikeState(status: $status,error: $error)';

  LikeState copyWith({
    Status? status,
    CustomError? error,
  }) {
    return LikeState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
