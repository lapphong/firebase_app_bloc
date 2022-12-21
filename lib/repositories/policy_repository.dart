import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/custom_error.dart';

class PolicyRepository {
  final FirebaseStorage? firebaseStorage;
  PolicyRepository({this.firebaseStorage});

  // Future<UploadTask?> uploadPdfToStorage({required File file}) async {
  //   try {
  //     Reference ref = firebaseStorage!
  //         .ref()
  //         .child('policy_terms')
  //         .child('policy_terms.pdf');
  //     final uploadTask =
  //         ref.putFile(file, SettableMetadata(contentType: 'application/pdf'));

  //     return uploadTask;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // Future<String> getUrlPdf() async {
  //   try {
  //     Reference ref =
  //         firebaseStorage!.ref().child('policy_terms/policy_terms.pdf');

  //     final url = await ref.getDownloadURL();

  //     return url;
  //   } catch (e) {
  //     throw CustomError(
  //       code: 'Exception',
  //       message: e.toString(),
  //       plugin: 'flutter_error/server_error',
  //     );
  //   }
  // }

  Future<File> loadPdfFirebase() async {
    try {
      Reference ref =
          FirebaseStorage.instance.ref().child('policy_terms/policy_terms.pdf');
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
}
