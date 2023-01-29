import 'dart:io';
import '../../models/models.dart';

abstract class UserBase {
  /*--------------------------------- Profile --------------------------------*/
  Future<User> getProfile({required String uid});
  Future<List<MyLearning>> getListMyLearning({required String uid});
  Future<void> updateProfile({required User user});
  Future<String> uploadImageToStorage({required File file});

  /*----------------------------- Favorite Teacher ---------------------------*/
  Future<void> updateFavoriteTeacherByUser({
    required String userID,
    required String teacherID,
  });
  Future<void> deleteFavoriteTeacherByUser({
    required String userID,
    required String teacherID,
  });

  /*------------------------------ Favorite Course ---------------------------*/
  Future<void> updateFavoriteCourseByUser({
    required String userID,
    required String productID,
  });
  Future<void> deleteFavoriteCourseByUser({
    required String userID,
    required String productID,
  });

  /*---------------------------- My Learning Course --------------------------*/
  Future<void> updateMyLearningByUser({
    required String userID,
    required List<String> listVideo,
    required String productID,
    required int progress,
  });

  Future<List<VideoProgress>> getListVideoProgressFromUser({
    required String userID,
    required String productID,
  });

  Future<void> updateVideoProgress({
    required String userID,
    required String productID,
    required String videoID,
    required int progress,
  });

  Future<void> updateTotalProgress({
    required String userID,
    required String productID,
    required int progress,
  });

  /*get MyFavorite MyLearning From User*/
  Future<Product> getProductByID({required String id});
}
