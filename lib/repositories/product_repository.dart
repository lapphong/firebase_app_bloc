import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_bloc/configs/api_path.dart';

class ProductRepository {
  //final FirebaseFirestore firebaseFirestore;
  //ProductRepository({required this.firebaseFirestore});

  Future<void> getAllProduct() async {
    await FirebaseFirestore.instance
        .collection(ApiPath.product())
        .get()
        .then((value) => {
              value.docs.forEach((result) async {
                print('⚡⚡ ${result.data()}');
                await FirebaseFirestore.instance
                    .collection(ApiPath.product())
                    .doc(result.id)
                    .collection(ApiPath.teacher())
                    .get()
                    .then((subColl) {
                  subColl.docs.forEach((element) {
                    print('👀👀 ${element.data()}');
                  });
                });
              })
            });
  }
}
