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
    on<GetListVideoByIDEvent>(_getListVideoByID,
        transformer: debounce(const Duration(milliseconds: _duration)));
  }

  EventTransformer<GetListCourseEvent> debounce<GetListCourseEvent>(
      Duration duration) {
    return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
  }

  Future<void> _getTeacherByID(
    GetTeacherByIDEvent event,
    Emitter<DetailState> emit,
  ) async {
    emit(state.copyWith(statusOverview: OverviewStatus.loading));

    try {
      final Teacher teacher = await appBase.getTeacherByID(id: event.id!);
      emit(state.copyWith(
          statusOverview: OverviewStatus.loaded, teacher: teacher));
    } on CustomError catch (e) {
      emit(state.copyWith(statusOverview: OverviewStatus.error, error: e));
    }
  }

  Future<void> _getListVideoByID(
    GetListVideoByIDEvent event,
    Emitter<DetailState> emit,
  ) async {
    final List<VideoCourse> listVideoFromDoc = [];
    late VideoCourse videoCourse = VideoCourse.initialVideo();
    emit(state.copyWith(statusCourse: CourseStatus.loading));
    try {
      for (var i = 0; i < event.courseVideoId.length; i++) {
        print('⚡⚡ $event.courseVideoId[i]');

        videoCourse =
            await appBase.getVideoCourseByID(id: event.courseVideoId[i]);
        listVideoFromDoc.add(videoCourse);
      }

      if (listVideoFromDoc.isNotEmpty) {
        emit(
          state.copyWith(
              statusCourse: CourseStatus.loaded, videoCourse: listVideoFromDoc),
        );
      }
    } on CustomError catch (e) {
      emit(state.copyWith(statusCourse: CourseStatus.error, error: e));
    }
  }
}
