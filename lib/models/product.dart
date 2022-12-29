import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String image;
  final String description;
  final String field;
  final String duration;
  final List<String> requirements;
  final List<String> listVideoID;
  final String teacherID;

  const Product({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.field,
    required this.duration,
    required this.requirements,
    required this.listVideoID,
    required this.teacherID,
  });

  factory Product.fromDoc(DocumentSnapshot productDoc) {
    final productData = productDoc.data() as Map<String, dynamic>;

    return Product(
      id: productDoc.id,
      title: productData['course_title'],
      image: productData['course_image'],
      description: productData['course_description'],
      field: productData['course_field'],
      duration: productData['course_duration'],
      requirements: List.from(productData['course_requirements']),
      listVideoID: List.from(productData['course_video_id']),
      teacherID: productData['course_teacher_id'],
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      image,
      description,
      field,
      duration,
      requirements,
      listVideoID,
      teacherID,
    ];
  }

  Product copyWith({
    String? id,
    String? title,
    String? image,
    String? description,
    String? field,
    String? duration,
    List<String>? requirements,
    List<String>? listVideoID,
    String? teacherID,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      field: field ?? this.field,
      duration: duration ?? this.duration,
      requirements: requirements ?? this.requirements,
      listVideoID: listVideoID ?? this.listVideoID,
      teacherID: teacherID ?? this.teacherID,
    );
  }
}
