import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../models/models.dart';
import '../../../../repositories/repository.dart';
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
  final UserBase userBase;
  final LikeTeacherCubit likeTeacherCubit;

  late final StreamSubscription likeSubscription;

  DetailBloc({
    required this.appBase,
    required this.userBase,
    required this.likeTeacherCubit,
  }) : super(DetailState.initial()) {
    on<GetTeacherByIDEvent>(_getTeacherByID);
    on<GetListVideoByIDEvent>(
      _getListVideoByID,
      transformer: debounce(const Duration(milliseconds: _duration)),
    );
    on<UpdateVideoProgressEvent>(_updateVideoProgress);

    likeSubscription = likeTeacherCubit.stream.listen((likeState) {
      updateVotedTeacher();
    });
  }

  Future<void> _updateVideoProgress(
    UpdateVideoProgressEvent event,
    Emitter<DetailState> emit,
  ) async {
    emit(state.copyWith(statusCourse: CourseStatus.initial));

    int index = state.videoProgress
        .indexWhere((element) => element.id == event.videoProgress!.id);
    final listVideoProgressNew = state.videoProgress;
    listVideoProgressNew.removeAt(index);
    listVideoProgressNew.insert(index, event.videoProgress!);

    int total = 0;
    for (var i = 0; i < state.videoProgress.length; i++) {
      total += state.videoProgress[i].progress;
    }
    total = total ~/ state.videoProgress.length;

    await userBase.updateTotalProgress(
      userID: event.userID!,
      productID: event.productID!,
      progress: total,
    );

    emit(state.copyWith(
      statusCourse: CourseStatus.loaded,
      videoProgress: listVideoProgressNew,
    ));
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

    try {
      for (var i = 0; i < event.product.listVideoID.length; i++) {
        videoCourse =
            await appBase.getVideoCourseByID(id: event.product.listVideoID[i]);
        listVideoFromDoc.add(videoCourse);
      }

      final listVideoProgress = await userBase.getListVideoProgressFromUser(
          userID: event.userID, productID: event.product.id);

      //sort by list videoCourse
      final Map<String, int> sortingOrderMap = {
        for (var i = 0; i < listVideoFromDoc.length; i++)
          listVideoFromDoc[i].id: i
      };

      listVideoProgress.sort((s1, s2) =>
          sortingOrderMap[s1.id]!.compareTo(sortingOrderMap[s2.id]!));
      //

      emit(state.copyWith(
        statusCourse: CourseStatus.loaded,
        videoCourse: listVideoFromDoc,
        videoProgress: listVideoProgress,
      ));
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
