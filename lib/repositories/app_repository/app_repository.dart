import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_bloc/repositories/app_repository/app_base.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../configs/api_path.dart';
import '../../models/models.dart';

class AppRepository implements AppBase {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  AppRepository({
    required this.firebaseStorage,
    required this.firebaseFirestore,
  });

  @override
  Future<List<Product>> getAllProduct(int limit) async {
    List<Product> list = [];
    try {
      await FirebaseFirestore.instance
          .collection(ApiPath.product())
          .limit(limit)
          .get()
          .then((value) {
        value.docs.forEach((element) => list.add(Product.fromDoc(element)));
      });

      if (list.isNotEmpty) {
        return list;
      }

      throw 'Product is empty';
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  @override
  Future<Teacher> getTeacherByID({required String id}) async {
    try {
      final teacherDoc = await FirebaseFirestore.instance
          .collection(ApiPath.teacher())
          .doc(id)
          .get();

      if (teacherDoc.exists) {
        final currentTeacher = Teacher.fromDoc(teacherDoc);
        return currentTeacher;
      }

      throw 'Teacher not found';
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }
}
