import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/transaction_model.dart';
import 'package:ud_grosir/app/services/transaction_service.dart';

class GrosirTransactionsController extends GetxController {
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

  Future<TransactionModel> updateTransaction(
      TransactionModel transactionModel, status) async {
    await TransactionService()
        .updateTransactionFromCheckout(transactionModel, status: status);
    return transactionModel;
  }
}
