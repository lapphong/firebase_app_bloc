part of 'tab_cubit.dart';

class TabState extends Equatable {
  final TabItem tab;

  const TabState({
    this.tab = TabItem.home,
  });

  @override
  String toString() => 'TabState(tab: $tab)';

  @override
  List<Object> get props => [tab];
}
