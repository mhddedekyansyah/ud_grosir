import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/transaction_model.dart';

class MainHomeUserController extends GetxController {
  int tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  Stream<List<TransactionModel>> fetchTransaction() async* {
    var transactions = FirebaseFirestore.instance
        .collection('transactions')
        .where('userId',
            isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber)
        .snapshots()
        .map((event) => event.docs
            .map((e) => TransactionModel.fromJson(e.id, e.data()))
            .toList());
    yield* transactions;
  }
}
