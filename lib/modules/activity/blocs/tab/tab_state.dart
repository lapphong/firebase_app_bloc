part of 'tab_cubit.dart';

enum TabStatus { incomplete, complete }

class TabState extends Equatable {
  final TabStatus tabStatus;
  const TabState({required this.tabStatus});

  factory TabState.initial() {
    return const TabState(tabStatus: TabStatus.incomplete);
  }

  @override
  List<Object> get props => [tabStatus];

  @override
  String toString() => 'TabState(tabStatus:$tabStatus)';

  TabState copyWith({
    TabStatus? tabStatus,
  }) {
    return TabState(
      tabStatus: tabStatus ?? this.tabStatus,
    );
  }
}
