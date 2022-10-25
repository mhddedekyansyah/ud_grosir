import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/cart_model.dart';
import 'package:ud_grosir/app/data/models/grosir_model.dart';
import 'package:ud_grosir/app/data/models/product_model.dart';
import 'package:ud_grosir/app/data/models/user_model.dart';

class UserHomeController extends GetxController {
  UserModel? user;

  Stream<List<GrosirModel>> fetchGrosir() async* {
    try {
      var grosir = FirebaseFirestore.instance
          .collection('grosirs')
          .snapshots()
          .map((event) => event.docs
              .map((e) => GrosirModel.fromJson(e.id, e.data()))
              .toList());

      yield* grosir;
    } catch (e) {
      print(e);
    }
  }

  Stream<UserModel> fetchUser() async* {
    try {
      var user = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
          .snapshots()
          .map((event) => UserModel.fromJson(
              event.id, event.data() as Map<String, dynamic>));
      user = user;
      yield* user;
    } catch (e) {
      print(e);
    }
  }

  Stream<List<CartModel>> cart() async* {
    try {
      Stream<List<CartModel>> cart = FirebaseFirestore.instance
          .collection('carts')
          .where('userId',
              isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber)
          .snapshots()
          .map((event) => event.docs
              .map((e) => CartModel.fromJson(e.id, e.data()))
              .toList());

      yield* cart;
    } catch (e) {
      print(e);
    }
  }
}
