import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MyLearning extends Equatable {
  final String id;
  final int progress;

  const MyLearning({required this.id, required this.progress});

  factory MyLearning.initial() {
    return const MyLearning(id: '', progress: 0);
  }

  factory MyLearning.fromDoc(DocumentSnapshot myLearningDoc) {
    final data = myLearningDoc.data() as Map<String, dynamic>?;

    return MyLearning(id: myLearningDoc.id, progress: data!['progress']);
  }

  @override
  List<Object> get props => [id, progress];

  MyLearning copyWith({String? id, int? progress}) {
    return MyLearning(id: id ?? this.id, progress: progress ?? this.progress);
  }
}
