import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/models/models.dart';
import 'package:firebase_app_bloc/repositories/app_repository/app_base.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppBase appBase;

  HomeBloc({required this.appBase}) : super(HomeState.initial()) {
    on<GetListCourseEvent>(_getListCourse);
  }

  Future<void> _getListCourse(
    GetListCourseEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final List<Product> listProduct = await appBase.getAllProduct();
      emit(state.copyWith(status: HomeStatus.loaded, list: listProduct));
    } on CustomError catch (e) {
      emit(state.copyWith(status: HomeStatus.error, error: e));
    }
  }
}
