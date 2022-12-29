import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VideoCourse extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imgVideo;
  final String video;
  const VideoCourse({
    required this.id,
    required this.title,
    required this.description,
    required this.imgVideo,
    required this.video,
  });

  factory VideoCourse.initialVideo() {
    return const VideoCourse(
      id: '',
      title: '',
      description: '',
      imgVideo: '',
      video: '',
    );
  }

  factory VideoCourse.fromDoc(DocumentSnapshot videoDoc) {
    final videoData = videoDoc.data() as Map<String, dynamic>;

    return VideoCourse(
      id: videoDoc.id,
      title: videoData['title'],
      description: videoData['description'],
      imgVideo: videoData['imgVideo'],
      video: videoData['video'],
    );
  }

  @override
  List<Object> get props => [id, title, description, imgVideo, video];

  VideoCourse copyWith({
    String? id,
    String? title,
    String? description,
    String? imgVideo,
    String? video,
  }) {
    return VideoCourse(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imgVideo: imgVideo ?? this.imgVideo,
      video: video ?? this.video,
    );
  }
}
