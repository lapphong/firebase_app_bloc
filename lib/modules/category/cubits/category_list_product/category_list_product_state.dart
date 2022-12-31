part of 'category_list_product_cubit.dart';

class CategoryListProductState extends Equatable {
  final List<Product> list;
  final CustomError error;

  const CategoryListProductState({
    required this.list,
    required this.error,
  });

  factory CategoryListProductState.initial() {
    return const CategoryListProductState(
      list: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [list, error];

  @override
  String toString() => 'CategoryListProductState(list: $list, error: $error)';

  CategoryListProductState copyWith({
    List<Product>? list,
    CustomError? error,
  }) {
    return CategoryListProductState(
      list: list ?? this.list,
      error: error ?? this.error,
    );
  }
}
