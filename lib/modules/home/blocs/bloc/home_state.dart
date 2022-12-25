part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Product> list;
  final CustomError error;
  const HomeState({
    required this.status,
    required this.list,
    required this.error,
  });

  factory HomeState.initial() {
    return const HomeState(
      status: HomeStatus.initial,
      list: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, list, error];

  @override
  String toString() => 'HomeState(status: $status, list: $list, error: $error)';

  HomeState copyWith({
    HomeStatus? status,
    List<Product>? list,
    CustomError? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      list: list ?? this.list,
      error: error ?? this.error,
    );
  }
}
