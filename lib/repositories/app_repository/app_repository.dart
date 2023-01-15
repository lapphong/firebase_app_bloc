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
  Future<List<Product>> getProductByLimit(int limit) async {
    List<Product> list = [];
    try {
      await firebaseFirestore
          .collection(ApiPath.product())
          .limit(limit)
          .orderBy('course_assessment_score', descending: true)
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
  Future<List<Product>> getNextProductByLimit({
    required int limit,
    required int nextAssessmentScore,
  }) async {
    List<Product> list = [];
    try {
      await firebaseFirestore
          .collection(ApiPath.product())
          .orderBy('course_assessment_score', descending: true)
          .startAfter([nextAssessmentScore])
          .limit(limit)
          .get()
          .then((value) {
            value.docs.forEach((element) => list.add(Product.fromDoc(element)));
          });

      return list;
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
  Future<List<Teacher>> getBestMentorByLimit(int limit) async {
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

  @override
  Future<List<Teacher>> getNextBestMentorByLimit({
    required int limit,
    required int nextVoted,
  }) async {
    List<Teacher> list = [];
    try {
      await firebaseFirestore
          .collection(ApiPath.teacher())
          .orderBy('voted')
          .where('voted', isGreaterThanOrEqualTo: 100)
          .endBefore([nextVoted])
          .limit(limit)
          .get()
          .then((value) {
            value.docs.forEach((element) => list.add(Teacher.fromDoc(element)));
          });

      return list;
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
  Future<List<Category>> getNameCategory() async {
    List<Category> list = [];
    try {
      await firebaseFirestore
          .collection(ApiPath.category())
          .get()
          .then((value) {
        value.docs.forEach((element) => list.add(Category.fromDoc(element)));
      });

      if (list.isNotEmpty) {
        return list;
      }

      throw 'Category is empty';
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
      final teacherDoc =
          await firebaseFirestore.collection(ApiPath.teacher()).doc(id).get();

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
      final videoDoc =
          await firebaseFirestore.collection(ApiPath.video()).doc(id).get();

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

  @override
  Future<List<Product>> getListProductByID({
    required String id,
    required String field,
    required int limit,
  }) async {
    try {
      List<Product> list = [];

      await firebaseFirestore
          .collection(ApiPath.product())
          .where(field, isEqualTo: id)
          .limit(limit)
          .get()
          .then((value) {
        value.docs.forEach((element) => list.add(Product.fromDoc(element)));
      });

      return list;
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
  Future<void> updateFavoriteInTeacher({
    required Teacher teacher,
    required int voted,
  }) async {
    try {
      await firebaseFirestore
          .collection(ApiPath.teacher())
          .doc(teacher.id)
          .update({
        'voted': voted,
      });
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  @override
  Future<void> updateTotalStudentInProduct({required Product product}) async {
    try {
      await firebaseFirestore
          .collection(ApiPath.product())
          .doc(product.id)
          .update({
        'course_student': product.studentTotal + 1,
      });
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }
}
