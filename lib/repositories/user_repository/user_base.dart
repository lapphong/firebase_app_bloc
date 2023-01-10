import 'dart:io';

import '../../models/models.dart';

abstract class UserBase {
  Future<User> getProfile({required String uid});
  Future<void> updateProfile({required User user});
  Future<String> uploadImageToStorage({required File file});
  Future<void> updateFavoriteTeacherByUser({
    required String userID,
    required String teacherID,
  });
  Future<void> deleteFavoriteTeacherByUser({
    required String userID,
    required String teacherID,
  });
  Future<void> updateFavoriteCourseByUser({
    required String userID,
    required String productID,
  });
  Future<void> deleteFavoriteCourseByUser({
    required String userID,
    required String productID,
  });
  Future<Product> getProductByIdInListFavoriteCourse({required String id});
}
