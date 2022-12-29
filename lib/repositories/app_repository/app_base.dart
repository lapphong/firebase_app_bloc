import 'package:firebase_app_bloc/models/models.dart';

abstract class AppBase {
  Future<List<Product>> getAllProduct(int limit);
  Future<List<Teacher>> getAllBestMentor(int limit);

  Future<VideoCourse> getVideoCourseByID({required String id});
  Future<Teacher> getTeacherByID({required String id});
}
