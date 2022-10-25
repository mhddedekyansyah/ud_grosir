import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/transaction_model.dart';

class HomeGrosirController extends GetxController {
  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
      .collection('products')
      .where('grosirId',
          isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber)
      .snapshots();

  Stream<List<TransactionModel>>? fetchTransactions() async* {
    var transactions = FirebaseFirestore.instance
        .collection('transactions')
        .where('grosirId',
            isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber)
        .snapshots()
        .map((event) => event.docs
            .map((e) => TransactionModel.fromJson(e.id, e.data()))
            .toList());

    yield* transactions;
  }
}
