import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/models.dart';
import '../cubits.dart';

part 'category_filtered_state.dart';

class CategoryFilteredCubit extends Cubit<CategoryFilteredState> {
  final CategoryListProductCubit categoryListProductCubit;

  late final StreamSubscription categoryListProductSubscription;

  CategoryFilteredCubit({
    required this.categoryListProductCubit,
  }) : super(CategoryFilteredState.initial()) {
    categoryListProductSubscription =
        categoryListProductCubit.stream.listen((categoryListProductState) {
      categoryListProductState.list.isNotEmpty
          ? emit(state.copyWith(
              filteredProduct: categoryListProductState.list,
              status: CategoryFilteredStatus.isNotEmpty))
          : emit(state.copyWith(
              filteredProduct: categoryListProductState.list,
              status: CategoryFilteredStatus.isEmpty));
    });
  }

  @override
  Future<void> close() {
    categoryListProductSubscription.cancel();
    return super.close();
  }
}
