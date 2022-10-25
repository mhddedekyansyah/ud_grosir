import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ud_grosir/app/data/models/cart_model.dart';
import 'package:ud_grosir/app/data/models/product_model.dart';
import 'package:ud_grosir/app/data/models/transaction_model.dart';
import 'package:ud_grosir/app/data/models/user_model.dart';

class TransactionService {
  CollectionReference transactionRef =
      FirebaseFirestore.instance.collection('transactions');

  Future<void> setTransactionFromCheckout(
      {required ProductModel product,
      required UserModel user,
      required total,
      required quantity}) async {
    try {
      transactionRef.add({
        'userId': user.id,
        'productId': product.id,
        'grosirId': product.grosirId,
        'productName': product.name,
        'total': total == 0 ? product.price : total,
        'quantity': quantity,
        'status': 'DIPROSES',
        'imgUrl': product.imgUrl,
        'userName': user.name,
        'userAddress': user.address,
        'mobileUser': user.mobile
      }).then((value) => print('Transaction success'));
    } catch (e) {
      throw e;
    }
  }

  Future<void> setTransactionFromCart(CartModel cart) async {
    try {
      transactionRef.add({
        'userId': cart.userId,
        'productId': cart.id,
        'grosirId': cart.grosirId,
        'productName': cart.productName,
        'total': cart.total,
        'quantity': cart.quantity,
        'userName': cart.userName,
        'userAddress': cart.address,
        'status': 'DIPROSES',
        'imgUrl': cart.imgUrl
      }).then((value) => print('transaction success'));
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateTransactionFromCheckout(TransactionModel transaction,
      {required status}) async {
    try {
      transactionRef.doc(transaction.id).update({
        'userId': transaction.userId,
        'productId': transaction.productId,
        'grosirId': transaction.grosirtId,
        'productName': transaction.productName,
        'total': transaction.total,
        'quantity': transaction.quantity,
        'status': status,
        'imgUrl': transaction.imgUrl
      }).then((_) => print('update transactions success'));
    } catch (e) {
      throw e;
    }
  }
}
