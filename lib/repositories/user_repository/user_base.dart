import 'dart:io';

import '../../models/models.dart';

abstract class UserBase {
  Future<User> getProfile({required String uid});
  Future<void> updateProfile({required User user});
  Future<String> uploadImageToStorage({required File file});
}
