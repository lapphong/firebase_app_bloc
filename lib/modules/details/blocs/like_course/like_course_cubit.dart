import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/models.dart';
import '../../../../repositories/repository.dart';

part 'like_course_state.dart';

class LikeCourseCubit extends Cubit<LikeCourseState> {
  final UserBase userBase;

  LikeCourseCubit({required this.userBase}) : super(LikeCourseState.initial());

  void changeLikeCourseStatusByUser({
    required String userID,
    required String productID,
    required bool isLike,
  }) {
    isLike ? likeCourse(userID, productID) : unLikeCourse(userID, productID);
  }

  Future<void> likeCourse(String userID, String productID) async {
    try {
      await userBase.updateFavoriteCourseByUser(
        userID: userID,
        productID: productID,
      );
      emit(state.copyWith(status: LikeCourseStatus.like));
    } on CustomError catch (e) {
      emit(state.copyWith(error: CustomError(message: e.message)));
    }
  }

  Future<void> unLikeCourse(String userID, String productID) async {
    try {
      await userBase.deleteFavoriteCourseByUser(
        userID: userID,
        productID: productID,
      );
      emit(state.copyWith(status: LikeCourseStatus.unlike));
    } on CustomError catch (e) {
      emit(state.copyWith(error: CustomError(message: e.message)));
    }
  }
}
