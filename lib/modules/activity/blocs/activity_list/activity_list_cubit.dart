import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../blocs/blocs.dart';
import '../../../../models/models.dart';
import '../../../../repositories/repository.dart';
import '../blocs.dart';

part 'activity_list_state.dart';

class ActivityListCubit extends Cubit<ActivityListState> {
  final UserBase userBase;
  final TabCubit tabCubit;
  final ProfileCubit profileCubit;

  late StreamSubscription tabSubscription;
  late StreamSubscription profileSubscription;

  ActivityListCubit({
    required this.userBase,
    required this.tabCubit,
    required this.profileCubit,
  }) : super(ActivityListState.initial()) {
    tabSubscription = tabCubit.stream.listen((tabState) {
      _setListProductByTab();
    });

    profileSubscription = profileCubit.stream.listen((profileState) {
      _setListProductByTab();
    });
  }

  void _setListProductByTab() {
    if (tabCubit.state.tabStatus == TabStatus.complete) {
      final List<MyLearning> listComplete = profileCubit.state.listMyLearning
          .where((element) => element.progress == 100)
          .toList();
      getListActivityByTab(listComplete);
    } else {
      final List<MyLearning> listComplete = profileCubit.state.listMyLearning
          .where((element) => element.progress < 100)
          .toList();
      getListActivityByTab(listComplete);
    }
  }

  Future<void> getListActivityByTab(List<MyLearning> list) async {
    final List<Product> listProductFromDoc = [];
    final List<double> listProgress = [];
    final List<double> listTimeLearned = [];

    late Product product = Product.initial();
    late double totalProgress = 0;

    try {
      for (var i = 0; i < list.length; i++) {
        product = await userBase.getProductByID(id: list[i].id);
        listProductFromDoc.add(product);
        listProgress.add(list[i].progress / 100);
        totalProgress += (list[i].progress / 100);
        listTimeLearned.add(percentOfNumber(
            list[i].progress / 100, double.parse(product.duration)));
      }

      emit(state.copyWith(
        activityStateStatus: ActivityStateStatus.loaded,
        list: listProductFromDoc,
        progressCourse: listProgress,
        totalProgress: totalProgress / listProgress.length,
        timeLearned: listTimeLearned,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        activityStateStatus: ActivityStateStatus.error,
        error: e,
      ));
    }
  }

  double percentOfNumber(double a, double b) => b * a / 100;
}
