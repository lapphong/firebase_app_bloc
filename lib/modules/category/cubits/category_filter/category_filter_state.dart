part of 'category_filter_cubit.dart';

enum CategoryFilterStatus { isFirst, isNotFirst }

class CategoryFilterState extends Equatable {
  final Category filterCategory;
  final CategoryFilterStatus status;

  const CategoryFilterState({
    required this.filterCategory,
    required this.status,
  });

  factory CategoryFilterState.initial() {
    return CategoryFilterState(
      filterCategory: Category.initial(),
      status: CategoryFilterStatus.isNotFirst,
    );
  }

  @override
  List<Object> get props => [filterCategory, status];

  @override
  String toString() =>
      'CategoryFilterState(filterCategory: $filterCategory,status: $status)';

  CategoryFilterState copyWith({
    Category? filterCategory,
    CategoryFilterStatus? status,
  }) {
    return CategoryFilterState(
      filterCategory: filterCategory ?? this.filterCategory,
      status: status ?? this.status,
    );
  }
}
