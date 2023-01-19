import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VideoCourse extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imgVideo;
  final String video;
  final String part;

  const VideoCourse({
    required this.id,
    required this.title,
    required this.description,
    required this.imgVideo,
    required this.video,
    required this.part,
  });

  factory VideoCourse.initialVideo() {
    return const VideoCourse(
      id: '',
      title: '',
      description: '',
      imgVideo: '',
      video: '',
      part: '',
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
      part: videoData['part'],
    );
  }

  @override
  List<Object> get props => [id, title, description, imgVideo, video, part];

  VideoCourse copyWith({
    String? id,
    String? title,
    String? description,
    String? imgVideo,
    String? video,
    String? part,
  }) {
    return VideoCourse(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imgVideo: imgVideo ?? this.imgVideo,
      video: video ?? this.video,
      part: part ?? this.part,
    );
  }
}
