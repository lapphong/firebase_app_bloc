part of 'playing_cubit.dart';

enum PlayingStatus { initial, initialized }

class PlayingState extends Equatable {
  final PlayingStatus status;

  const PlayingState({
    required this.status,
  });

  factory PlayingState.initial() {
    return const PlayingState(status: PlayingStatus.initial);
  }

  @override
  List<Object> get props => [status];

  @override
  String toString() {
    return 'PlayingState(status:$status)';
  }

  PlayingState copyWith({
    PlayingStatus? status,
  }) {
    return PlayingState(
      status: status ?? this.status,
    );
  }
}
