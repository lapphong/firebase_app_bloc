import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'playing_state.dart';

class PlayingCubit extends Cubit<PlayingState> {
  PlayingCubit() : super(PlayingState.initial());

  void initPlaying() => emit(state.copyWith(status: PlayingStatus.initialized));

  
}
