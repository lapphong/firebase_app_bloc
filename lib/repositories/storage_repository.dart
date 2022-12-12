import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final FirebaseStorage? firebaseStorage;

  StorageRepository({this.firebaseStorage});
  Future<String> uploadImageToStorage({required File file}) async {
    Reference ref = firebaseStorage!
        .ref()
        .child('user_images')
        .child(DateTime.now().toString());
    final uploadTask = ref.putFile(file);
    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }
}
