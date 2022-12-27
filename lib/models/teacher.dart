import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Teacher extends Equatable {
  final String id;
  final String name;
  final String imgUrl;
  final int voted;
  final String specialize;

  const Teacher({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.voted,
    required this.specialize,
  });

  factory Teacher.initialTeacher() {
    return const Teacher(
      id: '',
      name: '',
      imgUrl: '',
      voted: 0,
      specialize: '',
    );
  }

  factory Teacher.fromDoc(DocumentSnapshot teacherDoc) {
    final teacherData = teacherDoc.data() as Map<String, dynamic>;

    return Teacher(
      id: teacherDoc.id,
      name: teacherData['name'],
      imgUrl: teacherData['imgUrl'],
      voted: teacherData['voted'],
      specialize: teacherData['specialize'],
    );
  }

  @override
  List<Object> get props => [id, name, imgUrl, voted, specialize];

  @override
  String toString() {
    return 'Teacher(id: $id,name: $name,imgUrl:$imgUrl,voted: $voted,specialize:$specialize)';
  }

  Teacher copyWith({
    String? id,
    String? name,
    String? imgUrl,
    int? voted,
    String? specialize,
  }) {
    return Teacher(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      voted: voted ?? this.voted,
      specialize: specialize ?? this.specialize,
    );
  }
}
