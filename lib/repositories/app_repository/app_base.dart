import 'package:firebase_app_bloc/models/models.dart';

abstract class AppBase {
  Future<List<Product>> getAllProduct(int limit);
  Future<List<Teacher>> getAllMentor(int limit);
  
  Future<Teacher> getTeacherByID({required String id});
}
