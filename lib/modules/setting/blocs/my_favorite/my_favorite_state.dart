part of 'my_favorite_cubit.dart';

enum MyFavoriteStatus { init, loaded, error }

class MyFavoriteState extends Equatable {
  final MyFavoriteStatus status;
  final List<Product> listMyFavorite;
  final CustomError error;
  const MyFavoriteState({
    required this.status,
    required this.listMyFavorite,
    required this.error,
  });

  factory MyFavoriteState.initial() {
    return const MyFavoriteState(
      status: MyFavoriteStatus.init,
      listMyFavorite: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, listMyFavorite, error];

  @override
  String toString() =>
      'MyFavoriteState(status:$status,listMyFavorite:$listMyFavorite,error:$error)';

  MyFavoriteState copyWith({
    MyFavoriteStatus? status,
    List<Product>? listMyFavorite,
    CustomError? error,
  }) {
    return MyFavoriteState(
      status: status ?? this.status,
      listMyFavorite: listMyFavorite ?? this.listMyFavorite,
      error: error ?? this.error,
    );
  }
}
