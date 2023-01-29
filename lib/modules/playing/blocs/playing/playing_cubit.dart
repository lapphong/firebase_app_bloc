import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/models.dart';
import '../../../../repositories/repository.dart';
import '../../../details/blocs/blocs.dart';

part 'playing_state.dart';

class PlayingCubit extends Cubit<PlayingState> {
  final UserBase userBase;
  final DetailBloc detailBloc;

  PlayingCubit({
    required this.userBase,
    required this.detailBloc,
  }) : super(PlayingState.initial());

  void initPlaying() => emit(state.copyWith(status: PlayingStatus.initialized));

  Future<void> updateVideoProgress({
    required String userID,
    required Product product,
    required String videoID,
    required int durationVideo,
    required int durationTimeLearned,
  }) async {
    emit(state.copyWith(playingVideoStatus: PlayingVideoStatus.learning));
    try {
      late int progressVideo = percentOfNumber(
        durationVideo: durationVideo,
        durationTimeLearned: durationTimeLearned,
      ).toInt();
      late VideoProgress videoProgress = VideoProgress.initial();
      late VideoProgress list = detailBloc.state.videoProgress
          .where((element) => element.id == videoID)
          .first;

      if (list.progress != 100) {
        await userBase.updateVideoProgress(
          userID: userID,
          productID: product.id,
          videoID: videoID,
          progress: progressVideo >= 50 ? 100 : progressVideo,
        );
        videoProgress = VideoProgress(
            id: videoID, progress: progressVideo >= 50 ? 100 : progressVideo);
        emit(state.copyWith(
            videoProgress: videoProgress,
            playingVideoStatus: PlayingVideoStatus.learned));
      }
    } catch (e) {}
  }

  double percentOfNumber({
    required int durationTimeLearned,
    required int durationVideo,
  }) {
    return durationTimeLearned * 100 / durationVideo;
  }
}
