import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/product_model.dart';

class GrosirProductController extends GetxController {
  Stream<List<ProductModel>> fetchPrdouct(dynamic grosirId) async* {
    try {
      var products = FirebaseFirestore.instance
          .collection('products')
          .where('grosirId', isEqualTo: grosirId)
          .snapshots()
          .map((event) => event.docs
              .map((e) => ProductModel.fromJson(e.id, e.data()))
              .toList());
      yield* products;
    } catch (e) {
      print(e);
    }
  }
}
