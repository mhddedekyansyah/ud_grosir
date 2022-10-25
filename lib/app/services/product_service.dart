import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/grosir_model.dart';
import 'package:ud_grosir/app/data/models/product_model.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';

class ProductServices {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection('products');

  Future<void> setProduct(ProductModel productModel) async {
    print(productModel);
    try {
      _productRef.add({
        'grosirId': productModel.grosirId,
        'name': productModel.name,
        'imgUrl': productModel.imgUrl,
        'price': productModel.price,
        'stock': productModel.stock,
        'description': productModel.description,
      });
      print('add');
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProduct(ProductModel productModel, [int? quantity]) async {
    try {
      _productRef.doc(productModel.id).update({
        'grosirId': productModel.grosirId,
        'name': productModel.name,
        'imgUrl': productModel.imgUrl,
        'price': productModel.price,
        'stock': quantity != null
            ? productModel.stock! - quantity
            : productModel.stock,
        'description': productModel.description,
      });
    } catch (e) {
      throw e;
    }
  }
}
