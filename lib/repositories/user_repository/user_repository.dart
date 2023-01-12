import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_app_bloc/repositories/user_repository/user_base.dart';

import '../../configs/api_path.dart';
import '../../models/models.dart';

class UserRepository implements UserBase {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  UserRepository({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
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

  @override
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

  @override
  Future<String> uploadImageToStorage({required File file}) async {
    Reference ref = firebaseStorage
        .ref()
        .child(ApiPath.user_images())
        .child(DateTime.now().toString());
    final uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
  }

  @override
  Future<void> updateFavoriteTeacherByUser({
    required String userID,
    required String teacherID,
  }) async {
    try {
      await firebaseFirestore.collection(ApiPath.user()).doc(userID).update({
        'favorites_teacher': FieldValue.arrayUnion([teacherID]),
      });
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  @override
  Future<void> deleteFavoriteTeacherByUser({
    required String userID,
    required String teacherID,
  }) async {
    try {
      await firebaseFirestore.collection(ApiPath.user()).doc(userID).update({
        'favorites_teacher': FieldValue.arrayRemove([teacherID]),
      });
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  @override
  Future<void> updateFavoriteCourseByUser({
    required String userID,
    required String productID,
  }) async {
    try {
      await firebaseFirestore.collection(ApiPath.user()).doc(userID).update({
        'favorites_course': FieldValue.arrayUnion([productID]),
      });
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  @override
  Future<void> deleteFavoriteCourseByUser({
    required String userID,
    required String productID,
  }) async {
    try {
      await firebaseFirestore.collection(ApiPath.user()).doc(userID).update({
        'favorites_course': FieldValue.arrayRemove([productID]),
      });
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  @override
  Future<Product> getProductByID({
    required String id,
  }) async {
    try {
      final productDoc =
          await firebaseFirestore.collection(ApiPath.product()).doc(id).get();

      final currentProduct = Product.fromDoc(productDoc);
      return currentProduct;
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }
}
