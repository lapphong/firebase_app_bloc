import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Teacher extends Equatable {
  final String id;
  final String name;
  final String imgUrl;
  final List<String> specialize;

  const Teacher({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.specialize,
  });

  factory Teacher.fromDoc(DocumentSnapshot teacherDoc) {
    final teacherData = teacherDoc.data() as Map<String, dynamic>;

    return Teacher(
      id: teacherDoc.id,
      name: teacherData['name'],
      imgUrl: teacherData['imgUrl'],
      specialize: List.from(teacherData['specialize']),
    );
  }

  @override
  List<Object> get props => [id, name, imgUrl, specialize];

  @override
  String toString() {
    return 'Teacher(id: $id,name: $name,imgUrl:$imgUrl,specialize:$specialize)';
  }

  Teacher copyWith({
    String? id,
    String? name,
    String? imgUrl,
    List<String>? specialize,
  }) {
    return Teacher(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      specialize: specialize ?? this.specialize,
    );
  }
}
