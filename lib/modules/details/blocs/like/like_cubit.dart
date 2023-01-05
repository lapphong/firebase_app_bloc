import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/repositories/user_repository/user_base.dart';

import '../../../../models/models.dart';

part 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  final UserBase userBase;

  LikeCubit({required this.userBase}) : super(LikeState.initial());

  void changeStatusTeacherByUser({
    required String userID,
    required String teacherID,
    required bool isLike,
  }) {
    isLike ? likeTeacher(userID, teacherID) : unLikeTeacher(userID, teacherID);
  }

  Future<void> likeTeacher(String userID, String teacherID) async {
    try {
      await userBase.updateFavoriteByUser(
        userID: userID,
        teacherID: teacherID,
      );
      emit(state.copyWith(status: Status.like));
    } on CustomError catch (e) {
      emit(state.copyWith(error: CustomError(message: e.message)));
    }
  }

  Future<void> unLikeTeacher(String userID, String teacherID) async {
    try {
      await userBase.deleteFavoriteByUser(
        userID: userID,
        teacherID: teacherID,
      );
      emit(state.copyWith(status: Status.unlike));
    } on CustomError catch (e) {
      emit(state.copyWith(error: CustomError(message: e.message)));
    }
  }
}
