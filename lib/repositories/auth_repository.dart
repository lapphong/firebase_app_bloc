import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../configs/api_path.dart';
import '../models/custom_error.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AuthRepository {
  AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  final FirebaseFirestore firebaseFirestore;
  final auth.FirebaseAuth firebaseAuth;

  Stream<auth.User?> get user => firebaseAuth.userChanges();

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final auth.UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final signedInUser = userCredential.user!;
      await firebaseFirestore
          .collection(ApiPath.user())
          .doc(signedInUser.uid)
          .set({
        'name': name,
        'email': email,
        'profileImage': 'https://picsum.photos/300',
      });
    } on auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<File> loadPdfFirebase() async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(ApiPath.policy_terms())
          .child('policy_terms.pdf');
      final url = await ref.getDownloadURL();
      final bytes = await ref.getData();

      final filename = basename(url);
      final dir = await getApplicationDocumentsDirectory();

      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes!, flush: true);

      return file;
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}

// class PolicyRepository {
//   Future<UploadTask?> uploadPdfToStorage({required File file}) async {
//     try {
//       Reference ref = firebaseStorage!
//           .ref()
//           .child('policy_terms')
//           .child('policy_terms.pdf');
//       final uploadTask =
//           ref.putFile(file, SettableMetadata(contentType: 'application/pdf'));

//       return uploadTask;
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<String> getUrlPdf() async {
//     try {
//       Reference ref =
//           FirebaseStorage.instance.ref().child('policy_terms/policy_terms.pdf');

//       final url = await ref.getDownloadURL();

//       return url;
//     } catch (e) {
//       throw CustomError(
//         code: 'Exception',
//         message: e.toString(),
//         plugin: 'flutter_error/server_error',
//       );
//     }
//   }
// }
