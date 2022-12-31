import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/models/models.dart';
import 'package:firebase_app_bloc/repositories/app_repository/app_base.dart';
import 'package:rxdart/rxdart.dart';

part 'class_event.dart';
part 'class_state.dart';

const _limit = 2;
const _duration = 300;

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final AppBase appBase;

  ClassBloc({required this.appBase}) : super(ClassState.initial()) {
    on<GetListCourseEvent>(
      _getListCourse,
      transformer: debounce(const Duration(milliseconds: _duration)),
    );
  }

  EventTransformer<GetListCourseEvent> debounce<GetListCourseEvent>(
      Duration duration) {
    return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
  }

  Future<void> _getListCourse(
    GetListCourseEvent event,
    Emitter<ClassState> emit,
  ) async {
    emit(state.copyWith(status: ClassStatus.loading));

    try {
      final List<Product> listProduct = await appBase.getProductByLimit(_limit);
      emit(state.copyWith(status: ClassStatus.loaded, list: listProduct));
    } on CustomError catch (e) {
      emit(state.copyWith(status: ClassStatus.error, error: e));
    }
  }
}
