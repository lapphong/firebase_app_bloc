import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/repositories/user_repository/user_base.dart';

import '../../../../blocs/blocs.dart';
import '../../../../models/models.dart';

part 'like_teacher_state.dart';

class LikeTeacherCubit extends Cubit<LikeTeacherState> {
  final UserBase userBase;
  final ProfileCubit profileCubit;

  LikeTeacherCubit({
    required this.userBase,
    required this.profileCubit,
  }) : super(LikeTeacherState.initial());

  void changeLikeTeacherStatusByUser({
    required String teacherID,
    required bool isLike,
  }) {
    final String userID = profileCubit.state.user.id;
    isLike ? likeTeacher(userID, teacherID) : unLikeTeacher(userID, teacherID);
    profileCubit.updateUserFavoriteListTeacher(
      idTeacher: teacherID,
      isLike: isLike,
    );
  }

  Future<void> likeTeacher(String userID, String teacherID) async {
    try {
      await userBase.updateFavoriteTeacherByUser(
        userID: userID,
        teacherID: teacherID,
      );
      emit(state.copyWith(status: LikeTeacherStatus.like));
    } on CustomError catch (e) {
      emit(state.copyWith(error: CustomError(message: e.message)));
    }
  }

  Future<void> unLikeTeacher(String userID, String teacherID) async {
    try {
      await userBase.deleteFavoriteTeacherByUser(
        userID: userID,
        teacherID: teacherID,
      );
      emit(state.copyWith(status: LikeTeacherStatus.unlike));
    } on CustomError catch (e) {
      emit(state.copyWith(error: CustomError(message: e.message)));
    }
  }
}
