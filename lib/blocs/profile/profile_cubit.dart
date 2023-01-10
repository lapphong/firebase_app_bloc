import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/models/models.dart';
import 'package:firebase_app_bloc/repositories/user_repository/user_base.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  late User userUpdated;
  final UserBase userBase;

  ProfileCubit({
    required this.userBase,
  }) : super(ProfileState.initial());

  void updateUserFavoriteListTeacher({
    required String idTeacher,
    required bool isLike,
  }) {
    if (isLike) {
      userUpdated = state.user.copyWith(
          favoritesTeacher: [...state.user.favoritesTeacher, idTeacher]);
    } else {
      final listFavoritesNews = state.user.favoritesTeacher
          .where((String listFavoriteChild) => listFavoriteChild != idTeacher)
          .toList();

      userUpdated = state.user.copyWith(favoritesTeacher: listFavoritesNews);
    }
    emit(state.copyWith(user: userUpdated));
  }

  void updateUserFavoriteListProduct({
    required String idProduct,
    required bool isLike,
  }) {
    if (isLike) {
      userUpdated = state.user.copyWith(
          favoritesCourse: [...state.user.favoritesCourse, idProduct]);
    } else {
      final listFavoritesNews = state.user.favoritesCourse
          .where((String listFavoriteChild) => listFavoriteChild != idProduct)
          .toList();

      userUpdated = state.user.copyWith(favoritesCourse: listFavoritesNews);
    }
    emit(state.copyWith(user: userUpdated));
  }

  Future<void> getProfile({required String uid}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      final User user = await userBase.getProfile(uid: uid);
      emit(state.copyWith(profileStatus: ProfileStatus.loaded, user: user));
    } on CustomError catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error, error: e));
    }
  }
}
