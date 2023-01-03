import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.favorites,
  });

  final String id;
  final String name;
  final String email;
  final String profileImage;
  final List<String> favorites;

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      name: userData!['name'],
      email: userData['email'],
      profileImage: userData['profileImage'],
      favorites: List.from(userData['favorites']),
    );
  }

  factory User.initialUser() {
    return const User(
      id: '',
      name: '',
      email: '',
      profileImage: '',
      favorites: [],
    );
  }

  @override
  List<Object> get props => [id, name, email, profileImage, favorites];

  @override
  String toString() {
    return 'User(id:$id,name:$name,email:$email,profileImage:$profileImage,favorites:$favorites)';
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    List<String>? favorites,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      favorites: favorites ?? this.favorites,
    );
  }
}
