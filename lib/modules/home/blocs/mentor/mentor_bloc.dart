import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../models/models.dart';
import '../../../../repositories/app_repository/app_base.dart';

part 'mentor_event.dart';
part 'mentor_state.dart';

const _limit = 3;

class MentorBloc extends Bloc<MentorEvent, MentorState> {
  final AppBase appBase;

  MentorBloc({required this.appBase}) : super(MentorState.initial()) {
    on<GetListBestMentorEvent>(_getBestMentor);
    on<LoadMoreBestMentorEvent>(
      _getNextBestMentor,
      transformer: debounce(const Duration(milliseconds: 2000)),
    );
  }

  EventTransformer<SetSearchTermEvent> debounce<SetSearchTermEvent>(
      Duration duration) {
    return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
  }

  Future<void> _getBestMentor(
    MentorEvent event,
    Emitter<MentorState> emit,
  ) async {
    emit(state.copyWith(status: MentorStatus.loading));

    try {
      final listTeacher = await appBase.getBestMentorByLimit(_limit);
      emit(state.copyWith(status: MentorStatus.loaded, list: listTeacher));
    } on CustomError catch (e) {
      emit(state.copyWith(status: MentorStatus.error, error: e));
    }
  }

  Future<void> _getNextBestMentor(
    LoadMoreBestMentorEvent event,
    Emitter<MentorState> emit,
  ) async {
    try {
      if (state.hasReachedMax) return;
      final listNextTeacher = await appBase.getNextBestMentorByLimit(
        limit: _limit,
        nextVoted: state.list.last.voted,
      );

      listNextTeacher.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: MentorStatus.loaded,
              list: List.from(state.list)..addAll(listNextTeacher),
              hasReachedMax: false,
            ));
    } on CustomError catch (e) {
      emit(state.copyWith(status: MentorStatus.error, error: e));
    }
  }
}
