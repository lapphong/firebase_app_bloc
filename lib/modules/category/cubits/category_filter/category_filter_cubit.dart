import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../models/models.dart';
import '../cubits.dart';

part 'category_filter_state.dart';

class CategoryFilterCubit extends Cubit<CategoryFilterState> {
  final CategoryNameCubit categoryNameCubit;
  late final StreamSubscription categoryNameSubscription;

  CategoryFilterCubit({
    required this.categoryNameCubit,
  }) : super(CategoryFilterState.initial()) {
    categoryNameSubscription =
        categoryNameCubit.stream.listen((categoryNameState) {
      final currentFilterName = categoryNameState.list.first;
      emit(state.copyWith(
          filterCategory: currentFilterName,
          status: CategoryFilterStatus.isFirst));
    });
  }

  void changeFilter(Category category, int index) {
    index == 0
        ? emit(state.copyWith(
            filterCategory: category, status: CategoryFilterStatus.isFirst))
        : emit(state.copyWith(
            filterCategory: category, status: CategoryFilterStatus.isNotFirst));
  }

  @override
  Future<void> close() {
    categoryNameSubscription.cancel();
    return super.close();
  }
}
