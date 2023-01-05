import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_bloc/configs/api_path.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/models.dart';

class TestRepo {
//   Future<List<Category>> getCategory() async {
//     List<Category> list = [];
//     final dbRef = FirebaseDatabase.instance.ref(ApiPath.category());

//     dbRef.onValue.listen((event) => {

//           event.snapshot.children.forEach((child) {
//             list.add(Category.fromDoc(child.key));
//             print(child.key);
//             print(child.value);
//             return child.value;
//           })
//         });

// //    return posts;
//   }

  // Future<void> deleteFavoriteByUser(String uid, String teacherID) async {
  //   await FirebaseFirestore.instance
  //       .collection(ApiPath.user())
  //       .doc(uid)
  //       .update({
  //     'favorites': FieldValue.arrayRemove([teacherID]),
  //   });
  // }

  // Future<void> updateFavoriteByUser(String uid, String teacherID) async {
  //   await FirebaseFirestore.instance
  //       .collection(ApiPath.user())
  //       .doc(uid)
  //       .update({
  //     'favorites': FieldValue.arrayUnion([teacherID]),
  //   });
  // }

  // Future<List<Product>> getNextProductByLimit({
  //   required int limit,
  //   required int nextAssessmentScore,
  // }) async {
  //   List<Product> list = [];
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection(ApiPath.product())
  //         .orderBy('course_assessment_score', descending: true)
  //         .startAfter([nextAssessmentScore])
  //         .limit(limit)
  //         .get()
  //         .then((value) {
  //           value.docs.forEach((element) => list.add(Product.fromDoc(element)));
  //         });

  //     return list;
  //   } on FirebaseException catch (e) {
  //     throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
  //   } catch (e) {
  //     throw CustomError(
  //       code: 'Exception',
  //       message: e.toString(),
  //       plugin: 'flutter_error/server_error',
  //     );
  //   }
  // }

  // Future<List<Teacher>> getNextBestMentorByLimit({
  //   required int limit,
  //   required int nextVoted,
  // }) async {
  //   List<Teacher> list = [];
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection(ApiPath.teacher())
  //         .orderBy('voted')
  //         .where('voted', isGreaterThanOrEqualTo: 100)
  //         .endBefore([nextVoted])
  //         .limit(limit)
  //         .get()
  //         .then((value) {
  //           value.docs.forEach((element) => list.add(Teacher.fromDoc(element)));
  //         });

  //     return list;
  //   } on FirebaseException catch (e) {
  //     throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
  //   } catch (e) {
  //     throw CustomError(
  //       code: 'Exception',
  //       message: e.toString(),
  //       plugin: 'flutter_error/server_error',
  //     );
  //   }
  // }

  // Future<void> getMore() async {
  //   await FirebaseFirestore.instance
  //       .collection(ApiPath.teacher())
  //       .orderBy('voted')
  //       .endBefore([130])
  //       .get()
  //       .then((value) => value.docs.forEach((element) {
  //             print(element.data());
  //           }));
  // }

  // Future<VideoCourse> getVideoCourseByID({required String id}) async {
  //   try {
  //     final videoDoc = await FirebaseFirestore.instance
  //         .collection(ApiPath.video())
  //         .doc(id)
  //         .get();

  //     if (videoDoc.exists) {
  //       final currentVideo = VideoCourse.fromDoc(videoDoc);
  //       return currentVideo;
  //     }

  //     throw 'Video not found';
  //   } on FirebaseException catch (e) {
  //     throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
  //   } catch (e) {
  //     throw CustomError(
  //       code: 'Exception',
  //       message: e.toString(),
  //       plugin: 'flutter_error/server_error',
  //     );
  //   }
  // }

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
