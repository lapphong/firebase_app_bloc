import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/models.dart';
import '../../../../repositories/repository.dart';

part 'my_favorite_state.dart';

class MyFavoriteCubit extends Cubit<MyFavoriteState> {
  final UserBase userBase;
  MyFavoriteCubit({required this.userBase}) : super(MyFavoriteState.initial());

  Future<void> getListMyFavoriteCourse({required List<String> listID}) async {
    List<Product> listProductMyFavorite = [];
    late Product productMyFavorite = Product.initial();
    emit(state.copyWith(myFavoriteStatus: MyFavoriteStatus.initial));

    try {
      for (var i = 0; i < listID.length; i++) {
        productMyFavorite = await userBase.getProductByID(id: listID[i]);
        listProductMyFavorite.add(productMyFavorite);
      }

      emit(state.copyWith(
          myFavoriteStatus: MyFavoriteStatus.loaded,
          listMyFavorite: listProductMyFavorite));
    } on CustomError catch (e) {
      emit(state.copyWith(myFavoriteStatus: MyFavoriteStatus.error, error: e));
    }
  }

  Future<void> getListMyLearningCourse({
    required List<MyLearning> listID,
  }) async {
    final List<Product> listProductMyLearning = [];
    late Product productMyLearning = Product.initial();
    emit(state.copyWith(myLearningStatus: MyLearningStatus.initial));

    try {
      for (var i = 0; i < listID.length; i++) {
        productMyLearning = await userBase.getProductByID(id: listID[i].id);
        listProductMyLearning.add(productMyLearning);
      }

      emit(state.copyWith(
          myLearningStatus: MyLearningStatus.loaded,
          listMyLearning: listProductMyLearning));
    } on CustomError catch (e) {
      emit(state.copyWith(myLearningStatus: MyLearningStatus.error, error: e));
    }
  }
}
