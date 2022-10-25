import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/cart_model.dart';
import 'package:ud_grosir/app/data/models/product_model.dart';
import 'package:ud_grosir/app/data/models/user_model.dart';
import 'package:ud_grosir/app/services/cart_service.dart';
import 'package:ud_grosir/app/services/product_service.dart';
import 'package:ud_grosir/app/services/transaction_service.dart';

class CheckoutController extends GetxController {
  RxInt quantity = 1.obs;
  RxInt total = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void addQuantity(int n, int price) {
    if (total.value <= price) {
      total.value = price * (quantity.value + n);
      quantity.value += n;
    } else {
      quantity.value += n;
      total.value = price * quantity.value;
    }
  }

  void minusQuantity(int n, int price) {
    quantity.value -= n;
    total.value -= price;
  }

  Future<CartModel> addToCart(ProductModel product, UserModel user) async {
    try {
      CartModel cart = CartModel(
          userId: user.id,
          userName: user.name,
          address: user.address,
          productId: product.id,
          productName: product.name,
          grosirId: product.grosirId,
          imgUrl: product.imgUrl,
          quantity: quantity.value,
          total: total.value != 0 ? total.value : product.price);

      await CartService().setCart(cart).then((value) async =>
          {await ProductServices().updateProduct(product, quantity.value)});
      return cart;
    } catch (e) {
      throw e;
    }
  }

  Future<void> addToTransaction(
      ProductModel productModel, UserModel user) async {
    try {
      await TransactionService()
          .setTransactionFromCheckout(
              product: productModel,
              user: user,
              total: total.value,
              quantity: quantity.value)
          .then((value) async => await ProductServices()
              .updateProduct(productModel, quantity.value));
    } catch (e) {
      throw e;
    }
  }
}
