import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String image;
  final String description;
  final String field;
  final String duration;
  final String category;
  final List<String> requirements;
  final List<String> listVideoID;
  final int assessmentScore;
  final int reviewer;
  final int price;
  final int discount;
  final int studentTotal;
  final String teacherID;

  const Product({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.field,
    required this.duration,
    required this.category,
    required this.requirements,
    required this.listVideoID,
    required this.assessmentScore,
    required this.reviewer,
    required this.price,
    required this.discount,
    required this.studentTotal,
    required this.teacherID,
  });

  factory Product.initial() {
    return const Product(
      id: '',
      title: '',
      image: '',
      description: '',
      field: '',
      duration: '',
      category: '',
      requirements: [],
      listVideoID: [],
      assessmentScore: 0,
      reviewer: 0,
      price: 0,
      discount: 0,
      studentTotal: 0,
      teacherID: '',
    );
  }

  factory Product.fromDoc(DocumentSnapshot productDoc) {
    final productData = productDoc.data() as Map<String, dynamic>;

    return Product(
      id: productDoc.id,
      title: productData['course_title'],
      image: productData['course_image'],
      description: productData['course_description'],
      field: productData['course_field'],
      duration: productData['course_duration'],
      category: productData['course_category'],
      requirements: List.from(productData['course_requirements']),
      listVideoID: List.from(productData['course_video_id']),
      assessmentScore: productData['course_assessment_score'],
      reviewer: productData['course_reviewer'],
      price: productData['course_price'],
      discount: productData['course_discount'],
      studentTotal: productData['course_student'],
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
      category,
      requirements,
      listVideoID,
      assessmentScore,
      reviewer,
      price,
      discount,
      studentTotal,
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
    String? category,
    List<String>? requirements,
    List<String>? listVideoID,
    int? assessmentScore,
    int? reviewer,
    int? price,
    int? discount,
    int? studentTotal,
    String? teacherID,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      field: field ?? this.field,
      duration: duration ?? this.duration,
      category: category ?? this.category,
      requirements: requirements ?? this.requirements,
      listVideoID: listVideoID ?? this.listVideoID,
      assessmentScore: assessmentScore ?? this.assessmentScore,
      reviewer: reviewer ?? this.reviewer,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      studentTotal: studentTotal ?? this.studentTotal,
      teacherID: teacherID ?? this.teacherID,
    );
  }
}
