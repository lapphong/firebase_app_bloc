import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../blocs/blocs.dart';
import '../../../../models/models.dart';
import '../../../../repositories/app_repository/app_base.dart';
import '../blocs.dart';

part 'detail_event.dart';
part 'detail_state.dart';

const _duration = 300;

EventTransformer<GetListCourseEvent> debounce<GetListCourseEvent>(
    Duration duration) {
  return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
}

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final AppBase appBase;
  final LikeTeacherCubit likeTeacherCubit;

  late final StreamSubscription likeSubscription;

  DetailBloc({
    required this.appBase,
    required this.likeTeacherCubit,
  }) : super(DetailState.initial()) {
    on<GetTeacherByIDEvent>(
      _getTeacherByID,
      transformer: debounce(const Duration(milliseconds: _duration)),
    );
    on<GetListVideoByIDEvent>(
      _getListVideoByID,
      transformer: debounce(const Duration(milliseconds: _duration)),
    );

    likeSubscription = likeTeacherCubit.stream.listen((likeState) {
      updateVotedTeacher();
    });
  }

  late int votedCurrent = 0;
  Future<void> updateVotedTeacher() async {
    try {
      if (likeTeacherCubit.state.status == LikeTeacherStatus.like) {
        votedCurrent = state.teacher.voted + 1;
      } else if (likeTeacherCubit.state.status == LikeTeacherStatus.unlike) {
        votedCurrent = state.teacher.voted - 1;
      }

      await appBase.updateFavoriteInTeacher(
        teacher: state.teacher,
        voted: votedCurrent,
      );

      emit(
          state.copyWith(teacher: state.teacher.copyWith(voted: votedCurrent)));
    } on CustomError catch (e) {
      emit(state.copyWith(error: CustomError(message: e.message)));
    }
  }

  Future<void> _getTeacherByID(
    GetTeacherByIDEvent event,
    Emitter<DetailState> emit,
  ) async {
    emit(state.copyWith(statusOverview: OverviewStatus.initial));

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
    emit(state.copyWith(statusCourse: CourseStatus.initial));
    try {
      for (var i = 0; i < event.courseVideoId.length; i++) {
        videoCourse =
            await appBase.getVideoCourseByID(id: event.courseVideoId[i]);
        listVideoFromDoc.add(videoCourse);
      }

      emit(state.copyWith(
          statusCourse: CourseStatus.loaded, videoCourse: listVideoFromDoc));
    } on CustomError catch (e) {
      emit(state.copyWith(statusCourse: CourseStatus.error, error: e));
    }
  }

  @override
  Future<void> close() {
    likeSubscription.cancel();
    return super.close();
  }
}
