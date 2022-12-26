import 'package:firebase_app_bloc/models/models.dart';

abstract class AppBase {
  Future<List<Product>> getAllProduct(int limit);
  Future<Teacher> getTeacherByID({required String id});
}
