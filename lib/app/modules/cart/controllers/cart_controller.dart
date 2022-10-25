import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ud_grosir/app/data/models/cart_model.dart';
import 'package:ud_grosir/app/data/models/user_model.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';

import 'package:ud_grosir/app/services/transaction_service.dart';

class CartController extends GetxController {
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

  CollectionReference carts = FirebaseFirestore.instance.collection('carts');

  Future<void> deleteCart(uid) {
    return carts
        .doc(uid)
        .delete()
        .then((value) => print("Product Deleted"))
        .catchError((error) => print("Failed to delete product: $error"));
  }

  Future<void> addToTransaction(List<CartModel> cartModel) async {
    try {
      cartModel.forEach((e) async =>
          await TransactionService().setTransactionFromCart(e).then((_) async {
            await deleteCart(e.id);
          }));
    } catch (e) {
      throw e;
    }
  }
}
