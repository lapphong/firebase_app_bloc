import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/modules/root/enums/tab_item.dart';

part 'tab_state.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(const TabState());

  void setTab(TabItem tab) => emit(TabState(tab: tab));
}
