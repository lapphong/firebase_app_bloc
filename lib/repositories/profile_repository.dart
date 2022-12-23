import 'package:cloud_firestore/cloud_firestore.dart';

import '../configs/api_path.dart';
import '../models/models.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  ProfileRepository({required this.firebaseFirestore});

  Future<User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot userDoc =
          await firebaseFirestore.collection(ApiPath.user()).doc(uid).get();

      if (userDoc.exists) {
        final currentUser = User.fromDoc(userDoc);
        return currentUser;
      }

      throw 'User not found';
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> updateProfile({required User user}) async {
    try {
      await firebaseFirestore.collection(ApiPath.user()).doc(user.id).update({
        'name': user.name,
        'profileImage': user.profileImage,
      });
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }
}
