import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_bloc/repositories/app_repository/app_base.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AppRepository implements AppBase {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  AppRepository({
    required this.firebaseStorage,
    required this.firebaseFirestore,
  });
}
