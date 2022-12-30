import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../models/models.dart';
import '../cubits.dart';

part 'category_filter_state.dart';

class CategoryFilterCubit extends Cubit<CategoryFilterState> {
  final CategoryNameCubit categoryNameCubit;
  late final StreamSubscription filterNameSubscription;

  CategoryFilterCubit({required this.categoryNameCubit})
      : super(CategoryFilterState.initial()) {
    filterNameSubscription =
        categoryNameCubit.stream.listen((categoryNameState) {
      final currentFilterName = categoryNameState.list.first;
      emit(state.copyWith(filterCategory: currentFilterName));
    });
  }

  void changeFilter(Category category) {
    emit(state.copyWith(filterCategory: category));
  }

  @override
  Future<void> close() {
    filterNameSubscription.cancel();
    return super.close();
  }
}
