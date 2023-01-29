import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../blocs/blocs.dart';
import '../../../../models/models.dart';
import '../../../../repositories/repository.dart';

part 'activity_list_state.dart';

class ActivityListCubit extends Cubit<ActivityListState> {
  final UserBase userBase;
  final ProfileCubit profileCubit;

  late StreamSubscription profileSubscription;

  ActivityListCubit({
    required this.userBase,
    required this.profileCubit,
  }) : super(ActivityListState.initial()) {
    profileSubscription = profileCubit.stream.listen((profileState) {
      getListActivityByTab();
    });
  }

  Future<void> getListActivityByTab() async {
    emit(state.copyWith(activityStateStatus: ActivityStateStatus.initial));

    final listInComplete = profileCubit.state.listMyLearning
        .where((element) => element.progress < 100)
        .toList();
    final listComplete = profileCubit.state.listMyLearning
        .where((element) => element.progress == 100)
        .toList();
    final List<Product> listProductInComplete = [];
    final List<Product> listProductComplete = [];

    final List<double> listProgressInComplete = [];
    final List<double> listProgressComplete = [];

    final List<double> listTimeLearnedInComplete = [];
    final List<double> listTimeLearnedComplete = [];

    late Product product = Product.initial();
    late double totalProgress = 0;

    try {
      for (var i = 0; i < listInComplete.length; i++) {
        product = await userBase.getProductByID(id: listInComplete[i].id);
        listProductInComplete.add(product);
        listProgressInComplete.add(listInComplete[i].progress / 100);
        listTimeLearnedInComplete.add(percentOfNumber(
            listInComplete[i].progress / 100, double.parse(product.duration)));
        totalProgress += (listInComplete[i].progress / 100);
      }
      for (var i = 0; i < listComplete.length; i++) {
        product = await userBase.getProductByID(id: listComplete[i].id);
        listProductComplete.add(product);
        listProgressComplete.add(listComplete[i].progress / 100);
        listTimeLearnedComplete.add(percentOfNumber(
            listComplete[i].progress / 100, double.parse(product.duration)));
      }

      emit(state.copyWith(
        activityStateStatus: ActivityStateStatus.loaded,
        listInComplete: listProductInComplete,
        listComplete: listProductComplete,
        progressCourseInComplete: listProgressInComplete,
        progressCourseComplete: listProgressComplete,
        timeLearnedInComplete: listTimeLearnedInComplete,
        timeLearnedComplete: listTimeLearnedComplete,
        totalProgress:
            totalProgress != 0 ? totalProgress / listInComplete.length : 0,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        activityStateStatus: ActivityStateStatus.error,
        error: e,
      ));
    }
  }

  double percentOfNumber(double a, double b) => b * a / 100;

  @override
  Future<void> close() {
    profileSubscription.cancel();
    return super.close();
  }
}
