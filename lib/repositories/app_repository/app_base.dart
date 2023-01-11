import 'package:firebase_app_bloc/models/models.dart';

abstract class AppBase {
  Future<List<Product>> getProductByLimit(int limit);
  Future<List<Product>> getNextProductByLimit({
    required int limit,
    required int nextAssessmentScore,
  });
  Future<List<Teacher>> getBestMentorByLimit(int limit);
  Future<List<Teacher>> getNextBestMentorByLimit({
    required int limit,
    required int nextVoted,
  });
  Future<List<Category>> getNameCategory();

  Future<VideoCourse> getVideoCourseByID({required String id});
  Future<Teacher> getTeacherByID({required String id});
  Future<List<Product>> getListProductByID({
    required String id,
    required String field,
    required int limit,
  });
  Future<void> updateFavoriteInTeacher({
    required Teacher teacher,
    required int voted,
  });
}
