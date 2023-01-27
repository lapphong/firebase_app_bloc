import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VideoProgress extends Equatable {
  final String id;
  final int progress;

  const VideoProgress({required this.id, required this.progress});

  factory VideoProgress.initial() {
    return const VideoProgress(id: '', progress: 0);
  }

  factory VideoProgress.fromDoc(DocumentSnapshot videoProgressDoc) {
    final data = videoProgressDoc.data() as Map<String, dynamic>?;

    return VideoProgress(
      id: videoProgressDoc.id,
      progress: data!['progress'],
    );
  }

  @override
  List<Object> get props => [id, progress];

  VideoProgress copyWith({String? id, int? progress}) {
    return VideoProgress(
      id: id ?? this.id,
      progress: progress ?? this.progress,
    );
  }
}
