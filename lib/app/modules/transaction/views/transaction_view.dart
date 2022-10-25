import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/transaction_model.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends StatelessWidget {
  TransactionController transactionController =
      Get.put(TransactionController());
  TransactionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<TransactionModel>>(
      stream: transactionController.fetchTransactionsUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('something went wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return snapshot.data != null
              ? SafeArea(
                  child: Container(
                      margin: const EdgeInsets.all(24),
                      child: ListView(
                          children: snapshot.data!
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      tileColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      contentPadding: const EdgeInsets.all(5),
                                      title: Text("${e.productName}"),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("jumlah : ${e.quantity}"),
                                          Text("total : ${e.total}"),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: e.status == 'DIPROSES'
                                                    ? Colors.amber
                                                    : e.status == 'DITERIMA'
                                                        ? Colors.green
                                                        : Colors.red),
                                            child: Text(e.status.toLowerCase()),
                                          )
                                        ],
                                      ),
                                      leading: e.imgUrl != null
                                          ? Container(
                                              width: 100,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        '${e.imgUrl}',
                                                      ),
                                                      fit: BoxFit.cover)),
                                            )
                                          : Image.asset(
                                              'assets/images/bonbon.png',
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ))
                              .toList())))
              : Container();
        } else {
          return Center(child: Text('transaksi kosong'));
        }
      },
    ));
  }
}
