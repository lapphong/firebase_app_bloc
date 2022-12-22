import 'dart:io';

import 'package:firebase_app_bloc/configs/api_path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final FirebaseStorage? firebaseStorage;

  StorageRepository({this.firebaseStorage});
  Future<String> uploadImageToStorage({required File file}) async {
    Reference ref = firebaseStorage!
        .ref()
        .child(ApiPath.user_images())
        .child(DateTime.now().toString());
    final uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
  }
}
