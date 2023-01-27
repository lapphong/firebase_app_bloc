import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../blocs/blocs.dart';
import '../../../../models/models.dart';
import '../../../../repositories/repository.dart';

part 'buy_course_state.dart';

class BuyCourseCubit extends Cubit<BuyCourseState> {
  final AppBase appBase;
  final ProfileCubit profileCubit;

  BuyCourseCubit({
    required this.appBase,
    required this.profileCubit,
  }) : super(BuyCourseState.initial());

  void getOwnCourseFromUser({required String idProduct}) {
    final checkList = profileCubit.state.listMyLearning
        .where((element) => element.id == idProduct);

    checkList.isNotEmpty
        ? emit(state.copyWith(status: BuyCourseStatus.bought))
        : emit(state.copyWith(status: BuyCourseStatus.buy));
  }

  Future<void> buyCourse({required Product product}) async {
    try {
      await appBase.updateTotalStudentInProduct(product: product);
      await profileCubit.updateUserMyLearning(
        userID: profileCubit.state.user.id,
        listVideo: product.listVideoID,
        productID: product.id,
        progress: 0,
      );
      getOwnCourseFromUser(idProduct: product.id);
    } on CustomError catch (e) {
      emit(state.copyWith(error: CustomError(message: e.message)));
    }
  }
}
