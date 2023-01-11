import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/models.dart';
import '../../../../repositories/app_repository/app_base.dart';
import '../cubits.dart';

part 'category_list_product_state.dart';

const _limit = 20;

class CategoryListProductCubit extends Cubit<CategoryListProductState> {
  final AppBase appBase;
  final CategoryFilterCubit categoryFilterCubit;
  final CategorySearchCubit categorySearchCubit;

  late final StreamSubscription filterSubscription;
  late final StreamSubscription searchSubscription;

  CategoryListProductCubit({
    required this.appBase,
    required this.categoryFilterCubit,
    required this.categorySearchCubit,
  }) : super(CategoryListProductState.initial()) {
    filterSubscription =
        categoryFilterCubit.stream.listen((categoryFilterState) {
      _setFilteredProduct();
    });

    searchSubscription =
        categorySearchCubit.stream.listen((categorySearchState) {
      _setFilteredProduct();
    });
  }

  Future<void> _setFilteredProduct() async {
    List<Product> filteredProduct;
    categoryFilterCubit.state.status == CategoryFilterStatus.isFirst
        ? filteredProduct = await getListProductInCategory()
        : filteredProduct = await getListProductInCategoryByID();

    if (categorySearchCubit.state.searchProduct.isNotEmpty) {
      filteredProduct = filteredProduct
          .where((Product product) => product.title
              .toLowerCase()
              .contains(categorySearchCubit.state.searchProduct))
          .toList();
    }
    emit(state.copyWith(list: filteredProduct));
  }

  Future<List<Product>> getListProductInCategory() async {
    try {
      final listProduct = await appBase.getProductByLimit(_limit);

      return listProduct;
    } on CustomError catch (e) {
      emit(state.copyWith(error: e));
      return [];
    }
  }

  Future<List<Product>> getListProductInCategoryByID() async {
    try {
      final listProduct = await appBase.getListProductByID(
        id: categoryFilterCubit.state.filterCategory.id,
        field: 'course_category',
        limit: _limit,
      );
      return listProduct;
    } on CustomError catch (e) {
      emit(state.copyWith(error: e));
      return [];
    }
  }

  @override
  Future<void> close() {
    filterSubscription.cancel();
    searchSubscription.cancel();
    return super.close();
  }
}
