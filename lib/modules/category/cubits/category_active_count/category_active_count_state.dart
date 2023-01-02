part of 'category_active_count_cubit.dart';

class CategoryActiveCountState extends Equatable {
  final int activeProductCount;
  const CategoryActiveCountState({
    required this.activeProductCount,
  });

  factory CategoryActiveCountState.initial() {
    return const CategoryActiveCountState(activeProductCount: 0);
  }

  @override
  List<Object> get props => [activeProductCount];

  @override
  String toString() =>
      'CategoryActiveCountState(activeProductCount: $activeProductCount)';

  CategoryActiveCountState copyWith({
    int? activeProductCount,
  }) {
    return CategoryActiveCountState(
      activeProductCount: activeProductCount ?? this.activeProductCount,
    );
  }
}
