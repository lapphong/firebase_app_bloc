import 'package:cloud_firestore/cloud_firestore.dart';

//final userRef = FirebaseFirestore.instance.collection('user');

class ApiPath {
  /*------------------------------- FireStore --------------------------------*/
  static String user() => 'user';

  /*-------------------------------- Storage ---------------------------------*/
  static String user_images() => 'user_images';
  static String policy_terms() => 'policy_terms';

  // static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';
  // static String jobs(String uid) => 'users/$uid/jobs';
  // static String entry(String uid, String entryId) =>
  //     'users/$uid/entries/$entryId';
  // static String entries(String uid) => 'users/$uid/entries';
}
