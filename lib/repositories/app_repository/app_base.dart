import 'package:firebase_app_bloc/models/models.dart';

abstract class AppBase {
  Future<List<Product>> getProductByLimit(int limit);
  Future<List<Teacher>> getBestMentorByLimit(int limit);
  Future<List<Category>> getNameCategory();

  Future<VideoCourse> getVideoCourseByID({required String id});
  Future<Teacher> getTeacherByID({required String id});
  Future<List<Product>> getListProductInCategoryByID({
    required String id,
    required int limit,
  });
}
