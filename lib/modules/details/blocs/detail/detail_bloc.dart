import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/blocs/blocs.dart';
import 'package:firebase_app_bloc/modules/details/blocs/like/like_cubit.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../models/models.dart';
import '../../../../repositories/app_repository/app_base.dart';

part 'detail_event.dart';
part 'detail_state.dart';

const _duration = 300;

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final AppBase appBase;
  final LikeCubit likeCubit;

  late final StreamSubscription likeSubscription;

  DetailBloc({
    required this.appBase,
    required this.likeCubit,
  }) : super(DetailState.initial()) {
    on<GetTeacherByIDEvent>(
      _getTeacherByID,
      transformer: debounce(const Duration(milliseconds: _duration)),
    );
    on<GetListVideoByIDEvent>(_getListVideoByID,
        transformer: debounce(const Duration(milliseconds: _duration)));

    likeSubscription = likeCubit.stream.listen((likeState) {
      updateVotedTeacher();
    });
  }

  Future<void> updateVotedTeacher() async {
    try {
      if (likeCubit.state.status == Status.like) {
        await appBase.updateFavoriteInTeacher(
          teacher: state.teacher,
          idLike: true,
        );
      } else if (likeCubit.state.status == Status.unlike) {
        await appBase.updateFavoriteInTeacher(
          teacher: state.teacher,
          idLike: false,
        );
      }
    } on CustomError catch (e) {
      emit(state.copyWith(error: CustomError(message: e.message)));
    }
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
