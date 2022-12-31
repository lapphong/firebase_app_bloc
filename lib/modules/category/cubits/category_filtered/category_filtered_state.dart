part of 'category_filtered_cubit.dart';

enum CategoryFilteredStatus { isEmpty, isLoading, isNotEmpty }

class CategoryFilteredState extends Equatable {
  final List<Product> filteredProduct;
  final CategoryFilteredStatus status;

  const CategoryFilteredState({
    required this.filteredProduct,
    required this.status,
  });

  factory CategoryFilteredState.initial() {
    return const CategoryFilteredState(
      filteredProduct: [],
      status: CategoryFilteredStatus.isLoading,
    );
  }

  @override
  List<Object> get props => [filteredProduct];

  @override
  String toString() =>
      'CategoryFilteredState(filteredProduct: $filteredProduct)';

  CategoryFilteredState copyWith({
    List<Product>? filteredProduct,
    CategoryFilteredStatus? status,
  }) {
    return CategoryFilteredState(
      filteredProduct: filteredProduct ?? this.filteredProduct,
      status: status ?? this.status,
    );
  }
}
