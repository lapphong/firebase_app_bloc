part of 'category_search_cubit.dart';

class CategorySearchState extends Equatable {
  final String searchProduct;
  const CategorySearchState({
    required this.searchProduct,
  });

  factory CategorySearchState.initial() {
    return const CategorySearchState(searchProduct: '');
  }

  @override
  List<Object> get props => [searchProduct];

  @override
  String toString() => 'CategorySearchState(searchProduct: $searchProduct)';

  CategorySearchState copyWith({
    String? searchProduct,
  }) {
    return CategorySearchState(
      searchProduct: searchProduct ?? this.searchProduct,
    );
  }
}
