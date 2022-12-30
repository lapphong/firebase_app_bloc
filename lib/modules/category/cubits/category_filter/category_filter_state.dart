part of 'category_filter_cubit.dart';

class CategoryFilterState extends Equatable {
  final Category filterCategory;
  const CategoryFilterState({
    required this.filterCategory,
  });

  factory CategoryFilterState.initial() {
    return  CategoryFilterState(filterCategory: Category.initial());
  }

  @override
  List<Object> get props => [filterCategory];

  @override
  String toString() => 'CategoryFilterState(filterCategory: $filterCategory)';

  CategoryFilterState copyWith({
    Category? filterCategory,
  }) {
    return CategoryFilterState(
      filterCategory: filterCategory ?? this.filterCategory,
    );
  }
}
