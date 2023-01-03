part of 'class_bloc.dart';

enum ClassStatus { initial, loading, loaded, error }

class ClassState extends Equatable {
  final ClassStatus status;
  final List<Product> list;
  final CustomError error;
  final bool hasReachedMax;

  const ClassState({
    required this.status,
    required this.list,
    required this.error,
    required this.hasReachedMax,
  });

  factory ClassState.initial() {
    return const ClassState(
      status: ClassStatus.initial,
      list: [],
      error: CustomError(),
      hasReachedMax: false,
    );
  }

  @override
  List<Object> get props => [status, list, error, hasReachedMax];

  @override
  String toString() =>
      'ClassState(status: $status, list: $list, error: $error,hasReachedMax: $hasReachedMax)';

  ClassState copyWith({
    ClassStatus? status,
    List<Product>? list,
    CustomError? error,
    bool? hasReachedMax,
  }) {
    return ClassState(
      status: status ?? this.status,
      list: list ?? this.list,
      error: error ?? this.error,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
