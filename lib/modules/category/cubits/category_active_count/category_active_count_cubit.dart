import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../cubits.dart';

part 'category_active_count_state.dart';

class CategoryActiveCountCubit extends Cubit<CategoryActiveCountState> {
  final CategoryListProductCubit categoryListProductCubit;

  late final StreamSubscription categoryListProductSubscription;

  CategoryActiveCountCubit({
    required this.categoryListProductCubit,
  }) : super(CategoryActiveCountState.initial()) {
    categoryListProductSubscription =
        categoryListProductCubit.stream.listen((categoryListProductState) {
      emit(state.copyWith(
          activeProductCount: categoryListProductState.list.length));
    });
  }

  @override
  Future<void> close() {
    categoryListProductSubscription.cancel();
    return super.close();
  }
}
