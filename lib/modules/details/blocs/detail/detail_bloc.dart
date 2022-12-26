import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../models/models.dart';
import '../../../../repositories/app_repository/app_base.dart';

part 'detail_event.dart';
part 'detail_state.dart';

const _duration = 300;

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final AppBase appBase;

  DetailBloc({required this.appBase}) : super(DetailState.initial()) {
    on<GetTeacherByIDEvent>(
      _getTeacherByID,
      transformer: debounce(const Duration(milliseconds: _duration)),
    );
  }

  EventTransformer<GetListCourseEvent> debounce<GetListCourseEvent>(
      Duration duration) {
    return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
  }

  Future<void> _getTeacherByID(
    GetTeacherByIDEvent event,
    Emitter<DetailState> emit,
  ) async {
    emit(state.copyWith(status: DetailStatus.loading));

    try {
      final Teacher teacher = await appBase.getTeacherByID(id: event.id!);
      emit(state.copyWith(status: DetailStatus.loaded, teacher: teacher));
    } on CustomError catch (e) {
      emit(state.copyWith(status: DetailStatus.error, error: e));
    }
  }
}
