part of 'playing_cubit.dart';

enum PlayingStatus { initial, initialized }

enum PlayingVideoStatus { learning, learned }

class PlayingState extends Equatable {
  final PlayingStatus status;
  final PlayingVideoStatus playingVideoStatus;
  final VideoProgress videoProgress;

  const PlayingState({
    required this.status,
    required this.playingVideoStatus,
    required this.videoProgress,
  });

  factory PlayingState.initial() {
    return PlayingState(
      status: PlayingStatus.initial,
      playingVideoStatus: PlayingVideoStatus.learning,
      videoProgress: VideoProgress.initial(),
    );
  }

  @override
  List<Object> get props => [status, playingVideoStatus, videoProgress];

  @override
  String toString() {
    return 'PlayingState(status:$status,playingVideoStatus:$playingVideoStatus,videoProgress:$videoProgress)';
  }

  PlayingState copyWith({
    PlayingStatus? status,
    PlayingVideoStatus? playingVideoStatus,
    VideoProgress? videoProgress,
  }) {
    return PlayingState(
      status: status ?? this.status,
      playingVideoStatus: playingVideoStatus ?? this.playingVideoStatus,
      videoProgress: videoProgress ?? this.videoProgress,
    );
  }
}
