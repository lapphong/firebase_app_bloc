part of 'my_favorite_cubit.dart';

enum MyFavoriteStatus { initial, loaded, error }

enum MyLearningStatus { initial, loaded, error }

class MyFavoriteState extends Equatable {
  final MyFavoriteStatus myFavoriteStatus;
  final MyLearningStatus myLearningStatus;
  final List<Product> listMyFavorite;
  final List<Product> listMyLearning;
  final CustomError error;

  const MyFavoriteState({
    required this.myFavoriteStatus,
    required this.myLearningStatus,
    required this.listMyFavorite,
    required this.listMyLearning,
    required this.error,
  });

  factory MyFavoriteState.initial() {
    return const MyFavoriteState(
      myFavoriteStatus: MyFavoriteStatus.initial,
      myLearningStatus: MyLearningStatus.initial,
      listMyFavorite: [],
      listMyLearning: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [
        myFavoriteStatus,
        myLearningStatus,
        listMyFavorite,
        listMyLearning,
        error,
      ];

  @override
  String toString() =>
      'MyFavoriteState(myFavoriteStatus:$myFavoriteStatus,myLearningStatus:$myLearningStatus,listMyFavorite:$listMyFavorite,listMyLearning:$listMyLearning,error:$error)';

  MyFavoriteState copyWith({
    MyFavoriteStatus? myFavoriteStatus,
    MyLearningStatus? myLearningStatus,
    List<Product>? listMyFavorite,
    List<Product>? listMyLearning,
    CustomError? error,
  }) {
    return MyFavoriteState(
      myFavoriteStatus: myFavoriteStatus ?? this.myFavoriteStatus,
      myLearningStatus: myLearningStatus ?? this.myLearningStatus,
      listMyFavorite: listMyFavorite ?? this.listMyFavorite,
      listMyLearning: listMyLearning ?? this.listMyLearning,
      error: error ?? this.error,
    );
  }
}
