import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_state.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(TabState.initial());

  void changeTab(int value) {
    value == 1
        ? emit(state.copyWith(tabStatus: TabStatus.complete))
        : emit(state.copyWith(tabStatus: TabStatus.incomplete));
  }
}
