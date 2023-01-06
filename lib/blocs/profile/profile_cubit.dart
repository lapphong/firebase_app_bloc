import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/models/models.dart';
import 'package:firebase_app_bloc/repositories/user_repository/user_base.dart';

import '../../modules/details/blocs/blocs.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserBase userBase;
  //final LikeCubit likeCubit;

  //late final StreamSubscription likeSubscription;

  ProfileCubit({
    required this.userBase,
    //required this.likeCubit,
  }) : super(ProfileState.initial()) {
    //likeSubscription = likeCubit.stream.listen((likeState) {});
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
