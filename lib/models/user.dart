import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
  });

  final String id;
  final String name;
  final String email;
  final String profileImage;

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      name: userData!['name'],
      email: userData['email'],
      profileImage: userData['profileImage'],
    );
  }

  factory User.initialUser() {
    return const User(
      id: '',
      name: '',
      email: '',
      profileImage: '',
    );
  }

  @override
  List<Object> get props => [id, name, email, profileImage];

  @override
  String toString() {
    return 'User(id:$id,name:$name,email:$email,profileImage:$profileImage)';
  }
}
