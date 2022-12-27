part of 'class_bloc.dart';

enum ClassStatus { initial, loading, loaded, error }

class ClassState extends Equatable {
  final ClassStatus status;
  final List<Product> list;
  final CustomError error;
  
  const ClassState({
    required this.status,
    required this.list,
    required this.error,
  });

  factory ClassState.initial() {
    return const ClassState(
      status: ClassStatus.initial,
      list: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, list, error];

  @override
  String toString() => 'ClassState(status: $status, list: $list, error: $error)';

  ClassState copyWith({
    ClassStatus? status,
    List<Product>? list,
    CustomError? error,
  }) {
    return ClassState(
      status: status ?? this.status,
      list: list ?? this.list,
      error: error ?? this.error,
    );
  }
}
