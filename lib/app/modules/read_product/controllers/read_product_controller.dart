import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/product_model.dart';

class ReadProductController extends GetxController {
  Stream<List<ProductModel>> fetchProduct() async* {
    try {
      dynamic products = FirebaseFirestore.instance
          .collection('products')
          .where('grosirId',
              isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber)
          .snapshots()
          .map((event) => event.docs
              .map((e) => ProductModel.fromJson(e.id, e.data()))
              .toList());
      yield* products;
    } catch (e) {
      print(e);
    }
  }

  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<void> deleteProduct(dynamic uid) {
    return products
        .doc(uid)
        .delete()
        .then((value) => print("Product Deleted"))
        .catchError((error) => print("Failed to delete product: $error"));
  }
}
