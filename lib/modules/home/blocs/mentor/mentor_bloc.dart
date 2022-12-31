import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../models/models.dart';
import '../../../../repositories/app_repository/app_base.dart';

part 'mentor_event.dart';
part 'mentor_state.dart';

const _limit = 20;
const _duration = 300;

class MentorBloc extends Bloc<MentorEvent, MentorState> {
  final AppBase appBase;

  MentorBloc({required this.appBase}) : super(MentorState.initial()) {
    on<GetListBestMentorEvent>(
      _getAllMentor,
      transformer: debounce(const Duration(milliseconds: _duration)),
    );
  }

  EventTransformer<GetListBestMentorEvent> debounce<GetListCourseEvent>(
      Duration duration) {
    return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
  }

  Future<void> _getAllMentor(
    MentorEvent event,
    Emitter<MentorState> emit,
  ) async {
    emit(state.copyWith(status: MentorStatus.loading));

    try {
      final List<Teacher> listTeacher =
          await appBase.getBestMentorByLimit(_limit);
      emit(state.copyWith(status: MentorStatus.loaded, list: listTeacher));
    } on CustomError catch (e) {
      emit(state.copyWith(status: MentorStatus.error, error: e));
    }
  }
}
