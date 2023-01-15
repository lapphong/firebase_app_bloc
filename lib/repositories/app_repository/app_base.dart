import 'package:firebase_app_bloc/models/models.dart';

abstract class AppBase {
  /*--------------------------------- Product --------------------------------*/
  Future<List<Product>> getProductByLimit(int limit);
  Future<List<Product>> getNextProductByLimit({
    required int limit,
    required int nextAssessmentScore,
  });
  Future<List<Product>> getListProductByID({
    required String id,
    required String field,
    required int limit,
  });
  Future<void> updateTotalStudentInProduct({required Product product});

  /*--------------------------------- Mentor ---------------------------------*/
  Future<List<Teacher>> getBestMentorByLimit(int limit);
  Future<List<Teacher>> getNextBestMentorByLimit({
    required int limit,
    required int nextVoted,
  });
  Future<Teacher> getTeacherByID({required String id});
  Future<void> updateFavoriteInTeacher({
    required Teacher teacher,
    required int voted,
  });

  /*--------------------------------- Category -------------------------------*/
  Future<List<Category>> getNameCategory();

  /*------------------------------- Video Course -----------------------------*/
  Future<VideoCourse> getVideoCourseByID({required String id});
}
