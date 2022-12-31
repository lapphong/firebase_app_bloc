import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_bloc/configs/api_path.dart';

import '../models/models.dart';

class TestRepo {
  Future<VideoCourse> getVideoCourseByID({required String id}) async {
    try {
      final videoDoc = await FirebaseFirestore.instance
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

  // Future<List<Product>> getAllProduct() async {
  //   List<Product> list = [];
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection(ApiPath.product())
  //         .limit(2)
  //         .get()
  //         .then((value) {
  //       value.docs.forEach((element) => list.add(Product.fromDoc(element)));
  //     });

  //     if (list.isNotEmpty) {
  //       return list;
  //     }

  //     throw 'Product is empty';
  //   } on FirebaseException catch (e) {
  //     throw CustomError(
  //       code: e.code,
  //       message: e.message!,
  //       plugin: e.plugin,
  //     );
  //   } catch (e) {
  //     throw CustomError(
  //       code: 'Exception',
  //       message: e.toString(),
  //       plugin: 'flutter_error/server_error',
  //     );
  //   }
  // }

  // Future<Teacher> getTeacher({required String id}) async {
  //   try {
  //     final teacherDoc = await FirebaseFirestore.instance
  //         .collection(ApiPath.teacher())
  //         .doc(id)
  //         .get();

  //     if (teacherDoc.exists) {
  //       final currentTeacher = Teacher.fromDoc(teacherDoc);
  //       return currentTeacher;
  //     }

  //     throw 'Teacher not found';
  //   } on FirebaseException catch (e) {
  //     throw CustomError(
  //       code: e.code,
  //       message: e.message!,
  //       plugin: e.plugin,
  //     );
  //   } catch (e) {
  //     throw CustomError(
  //       code: 'Exception',
  //       message: e.toString(),
  //       plugin: 'flutter_error/server_error',
  //     );
  //   }
  // }

  // Future<List<String>> getValueInDocumentID({
  //   required String path,
  //   required String key,
  // }) async {
  //   List<String> list = [];

  //   await FirebaseFirestore.instance.collection(path).get().then((value) {
  //     value.docs.forEach((element) {
  //       list.add(element[key]);
  //     });
  //   });

  //   return list;
  // }

  // Future<List<Teacher>> getAllTeacher() async {
  //   List<Teacher> listTeacher = [];
  //   List<String> listTeacherID = await getValueInDocumentID(
  //     path: ApiPath.product(),
  //     key: 'course_teacher_id',
  //   );

  //   listTeacherID.forEach((courseTeacherId) async {
  //     print(courseTeacherId);
  //     final result = await FirebaseFirestore.instance
  //         .collection(ApiPath.teacher())
  //         .doc(courseTeacherId)
  //         .get();

  //     listTeacher.add(Teacher.fromDoc(result));
  //     print(listTeacher.length);
  //   });
  //   print(listTeacher.length);

  //   return listTeacher;
  // }

}