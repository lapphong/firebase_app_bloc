import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../models/models.dart';
import '../../../../repositories/app_repository/app_base.dart';
import '../blocs.dart';

part 'detail_event.dart';
part 'detail_state.dart';

const _duration = 300;

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final AppBase appBase;
  final LikeTeacherCubit likeCubit;

  late final StreamSubscription likeSubscription;

  DetailBloc({
    required this.appBase,
    required this.likeCubit,
  }) : super(DetailState.initial()) {
    on<GetTeacherByIDEvent>(
      _getTeacherByID,
      transformer: debounce(const Duration(milliseconds: _duration)),
    );
    on<GetListVideoByIDEvent>(
      _getListVideoByID,
      transformer: debounce(const Duration(milliseconds: _duration)),
    );

    likeSubscription = likeCubit.stream.listen((likeState) {
      updateVotedTeacher();
    });
  }

  EventTransformer<GetListCourseEvent> debounce<GetListCourseEvent>(
      Duration duration) {
    return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
  }

  late int votedCurrent = 0;
  Future<void> updateVotedTeacher() async {
    try {
      if (likeCubit.state.status == LikeTeacherStatus.like) {
        votedCurrent = state.teacher.voted + 1;
      } else if (likeCubit.state.status == LikeTeacherStatus.unlike) {
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
}
