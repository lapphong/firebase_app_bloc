import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../configs/api_path.dart';
import '../models/custom_error.dart';

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

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
