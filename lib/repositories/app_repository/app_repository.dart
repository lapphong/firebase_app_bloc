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
      await firebaseFirestore
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
  Future<List<Teacher>> getAllBestMentor(int limit) async {
    List<Teacher> list = [];
    try {
      await firebaseFirestore
          .collection(ApiPath.teacher())
          .orderBy('voted', descending: true)
          .where('voted', isGreaterThanOrEqualTo: 100)
          .limit(limit)
          .get()
          .then((value) {
        value.docs.forEach((element) => list.add(Teacher.fromDoc(element)));
      });

      if (list.isNotEmpty) {
        return list;
      }

      throw 'Teacher is empty';
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

  /*--------------------------------------------------------------------------*/

  @override
  Future<Teacher> getTeacherByID({required String id}) async {
    try {
      final teacherDoc = await firebaseFirestore
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

  @override
  Future<VideoCourse> getVideoCourseByID({required String id}) async {
    try {
      final videoDoc = await firebaseFirestore
          .collection(ApiPath.video())
          .doc(id)
          .get();

      if (videoDoc.exists) {
        final currentVideo = VideoCourse.fromDoc(videoDoc);
        return currentVideo;
      }

      throw 'Video not found';
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
