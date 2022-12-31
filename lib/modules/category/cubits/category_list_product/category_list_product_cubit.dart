import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/models.dart';
import '../../../../repositories/app_repository/app_base.dart';
import '../cubits.dart';

part 'category_list_product_state.dart';

const _limit = 2;

class CategoryListProductCubit extends Cubit<CategoryListProductState> {
  final AppBase appBase;
  final CategoryFilterCubit categoryFilterCubit;
  late final StreamSubscription filterSubscription;


  CategoryListProductCubit({
    required this.appBase,
    required this.categoryFilterCubit,
  }) : super(CategoryListProductState.initial()) {
    filterSubscription =
        categoryFilterCubit.stream.listen((categoryFilterState) {
      categoryFilterState.status == CategoryFilterStatus.isFirst
          ? getListProductInCategory()
          : getListProductInCategoryByID();
    });
  }

  Future<void> getListProductInCategoryByID() async {
    try {
      final listProduct = await appBase.getListProductInCategoryByID(
        id: categoryFilterCubit.state.filterCategory.id,
        limit: 20,
      );
      emit(state.copyWith(list: listProduct));
    } on CustomError catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> getListProductInCategory() async {
    try {
      final List<Product> listProduct = await appBase.getProductByLimit(_limit);
      emit(state.copyWith(list: listProduct));
    } on CustomError catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
