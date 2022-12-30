import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String categoryName;

  const Category({
    required this.id,
    required this.categoryName,
  });

  factory Category.initial() {
    return const Category(id: '', categoryName: '');
  }

  factory Category.fromDoc(DocumentSnapshot categoryDoc) {
    final categoryData = categoryDoc.data() as Map<String, dynamic>;

    return Category(
      id: categoryDoc.id,
      categoryName: categoryData['categoryName'],
    );
  }

  @override
  List<Object> get props => [id, categoryName];

  Category copyWith({
    String? id,
    String? categoryName,
  }) {
    return Category(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
    );
  }
}
