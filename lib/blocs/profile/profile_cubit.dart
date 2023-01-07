import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/models/models.dart';
import 'package:firebase_app_bloc/repositories/user_repository/user_base.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserBase userBase;

  ProfileCubit({
    required this.userBase,
  }) : super(ProfileState.initial());

  late User userNew;
  void updateUserFavoriteList({
    required String idTeacher,
    required bool isLike,
  }) {
    if (isLike) {
      userNew =
          state.user.copyWith(favorites: [...state.user.favorites, idTeacher]);
    } else {
      final listFavoritesNews = state.user.favorites
          .where((String listFavoriteChild) => listFavoriteChild != idTeacher)
          .toList();

      userNew = state.user.copyWith(favorites: listFavoritesNews);
    }
    emit(state.copyWith(user: userNew));
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
