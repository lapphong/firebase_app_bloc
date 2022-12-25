import 'package:firebase_app_bloc/models/models.dart';

abstract class AppBase {
  Future<List<Product>> getAllProduct();
  Future<Teacher> getTeacherByID({required String id});
}
