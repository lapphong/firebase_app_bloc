import 'dart:io';

import '../../models/models.dart';

abstract class UserBase {
  Future<User> getProfile({required String uid});
  Future<void> updateProfile({required User user});
  Future<String> uploadImageToStorage({required File file});
  Future<void> updateFavoriteByUser({
    required String userID,
    required String teacherID,
  });
  Future<void> deleteFavoriteByUser({
    required String userID,
    required String teacherID,
  });
}
