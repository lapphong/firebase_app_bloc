part of 'buy_course_cubit.dart';

enum BuyCourseStatus { buy, bought }

class BuyCourseState extends Equatable {
  final BuyCourseStatus status;
  final CustomError error;

  const BuyCourseState({required this.status, required this.error});

  factory BuyCourseState.initial() {
    return const BuyCourseState(
      status: BuyCourseStatus.buy,
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, error];

  @override
  String toString() => 'BuyCourseState(status:$status,error:$error)';

  BuyCourseState copyWith({BuyCourseStatus? status, CustomError? error}) {
    return BuyCourseState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
