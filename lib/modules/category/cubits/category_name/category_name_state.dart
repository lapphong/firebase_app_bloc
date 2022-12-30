part of 'category_name_cubit.dart';

class CategoryNameState extends Equatable {
  final List<Category> list;
  const CategoryNameState({
    required this.list,
  });

  factory CategoryNameState.initial() {
    return const CategoryNameState(list: []);
  }

  @override
  List<Object> get props => [list];

  @override
  String toString() => 'CategoryNameState(list: $list)';

  CategoryNameState copyWith({
    List<Category>? list,
  }) {
    return CategoryNameState(
      list: list ?? this.list,
    );
  }
}
