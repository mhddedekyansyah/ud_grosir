import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/transaction_model.dart';

import 'package:ud_grosir/app/routes/app_pages.dart';

import '../controllers/home_grosir_controller.dart';

class HomeGrosirView extends GetView<HomeGrosirController> {
  HomeGrosirController grosir = Get.put(HomeGrosirController());
  HomeGrosirView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grosir'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.toNamed(Routes.REGISTER);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: grosir.usersStream,
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.READ_PRODUCT);
                  },
                  child: Card(
                    margin: EdgeInsets.all(24),
                    color: Colors.green,
                    child: SizedBox(
                      height: 135,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Produk',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${snapshot.data?.docs.length ?? 0}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                              size: 70,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.GROSIR_TRANSACTIONS);
            },
            child: Card(
              margin: EdgeInsets.all(24),
              color: Colors.amber,
              child: SizedBox(
                height: 135,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Transaksi',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          StreamBuilder<List<TransactionModel>>(
                              stream: controller.fetchTransactions(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('something went wrong'),
                                  );
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return snapshot.data != null
                                    ? Text(
                                        '${snapshot.data!.length}',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        '0',
                                        style: TextStyle(color: Colors.white),
                                      );
                              })
                        ],
                      ),
                      Icon(
                        Icons.shopping_cart_sharp,
                        color: Colors.white,
                        size: 70,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_PRODUCT);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
