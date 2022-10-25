import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/transaction_model.dart';

import '../controllers/grosir_transactions_controller.dart';

class GrosirTransactionsView extends GetView<GrosirTransactionsController> {
  // GrosirTransactionsController controller =
  //     Get.put(GrosirTransactionsController());
  GrosirTransactionsView({Key? key}) : super(key: key);
  List<String> status = ['DITERIMA', 'DIBATALKAN'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<TransactionModel>>(
      stream: controller.fetchTransactions(),
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

        return snapshot.data != null
            ? SafeArea(
                child: Container(
                    margin: const EdgeInsets.all(24),
                    child: ListView(
                        children: snapshot.data!
                            .map((snap) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    contentPadding: const EdgeInsets.all(15),
                                    title: Text("${snap.userName ?? 'name'}"),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${snap.addressUser ?? 'address'}"),
                                        Text("${snap.userId ?? 'mobile'}"),
                                        Text(
                                            "${snap.productName ?? 'product'}"),
                                        Text("jumlah : ${snap.quantity}"),
                                        Text("total : ${snap.total}"),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        snap.status == 'DIPROSES'
                                            ? DropdownButton(
                                                hint: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: snap.status ==
                                                                'DIPROSES'
                                                            ? Colors.amber
                                                            : snap.status ==
                                                                    'DITERIMA'
                                                                ? Colors.green
                                                                : Colors.red),
                                                    child: Text(snap.status
                                                        .toLowerCase())),
                                                items: status
                                                    .map(
                                                        (e) => DropdownMenuItem(
                                                              value: e,
                                                              child: Text(e),
                                                            ))
                                                    .toList(),
                                                onChanged: (value) async {
                                                  await controller
                                                      .updateTransaction(
                                                          snap, value);
                                                })
                                            : Container(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: snap.status ==
                                                            'DIPROSES'
                                                        ? Colors.amber
                                                        : snap.status ==
                                                                'DITERIMA'
                                                            ? Colors.green
                                                            : Colors.red),
                                                child: Text(
                                                    snap.status.toLowerCase())),
                                      ],
                                    ),
                                    leading: snap.imgUrl != null &&
                                            snap.imgUrl!.isNotEmpty
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              '${snap.imgUrl}',
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              'assets/images/bonbon.png',
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ))
                            .toList())))
            : const Center(child: Text('transaksi kosong'));
      },
    ));
  }
}
