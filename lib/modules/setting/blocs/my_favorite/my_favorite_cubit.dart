import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/models.dart';
import '../../../../repositories/repository.dart';

part 'my_favorite_state.dart';

class MyFavoriteCubit extends Cubit<MyFavoriteState> {
  final UserBase userBase;
  MyFavoriteCubit({required this.userBase}) : super(MyFavoriteState.initial());

  Future<void> getListMyFavoriteCourse({required List<String> listID}) async {
    final List<Product> listProductMyFavorite = [];
    late Product productMyFavorite = Product.initial();
    emit(state.copyWith(status: MyFavoriteStatus.init));

    try {
      for (var i = 0; i < listID.length; i++) {
        productMyFavorite =
            await userBase.getProductByIdInListFavoriteCourse(id: listID[i]);
        listProductMyFavorite.add(productMyFavorite);
      }

      emit(state.copyWith(
          status: MyFavoriteStatus.loaded,
          listMyFavorite: listProductMyFavorite));
    } on CustomError catch (e) {
      emit(state.copyWith(status: MyFavoriteStatus.error, error: e));
    }
  }
}
