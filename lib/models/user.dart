import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.diamond,
    required this.favoritesTeacher,
    required this.favoritesCourse,
  });

  final String id;
  final String name;
  final String email;
  final String profileImage;
  final int diamond;
  final List<String> favoritesTeacher;
  final List<String> favoritesCourse;

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      name: userData!['name'],
      email: userData['email'],
      profileImage: userData['profileImage'],
      diamond: userData['diamond'],
      favoritesTeacher: List.from(userData['favorites_teacher']),
      favoritesCourse: List.from(userData['favorites_course']),
    );
  }

  factory User.initialUser() {
    return const User(
      id: '',
      name: '',
      email: '',
      profileImage: '',
      diamond: 0,
      favoritesTeacher: [],
      favoritesCourse: [],
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        email,
        profileImage,
        diamond,
        favoritesTeacher,
        favoritesCourse,
      ];

  @override
  String toString() =>
      'User(id:$id,name:$name,email:$email,profileImage:$profileImage,diamond:$diamond,favoritesTeacher:$favoritesTeacher,favoritesCourse:$favoritesCourse)';

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    int? diamond,
    List<String>? favoritesTeacher,
    List<String>? favoritesCourse,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      diamond: diamond ?? this.diamond,
      favoritesTeacher: favoritesTeacher ?? this.favoritesTeacher,
      favoritesCourse: favoritesCourse ?? this.favoritesCourse,
    );
  }
}
