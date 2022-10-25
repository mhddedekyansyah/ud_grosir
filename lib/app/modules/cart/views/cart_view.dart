import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/cart_model.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder<List<CartModel>>(
        stream: controller.cart(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return snapshot.data!.isNotEmpty
              ? SafeArea(
                  child: Container(
                      margin: const EdgeInsets.all(24),
                      child: Stack(children: [
                        ListView.separated(
                            itemBuilder: (context, index) => ListTile(
                                  contentPadding: const EdgeInsets.all(15),
                                  leading:
                                      snapshot.data![index].imgUrl != null &&
                                              snapshot.data![index].imgUrl!
                                                  .isNotEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                '${snapshot.data![index].imgUrl}',
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Image.asset(
                                              'assets/images/bonbon.png',
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                  tileColor: Colors.white,
                                  title: Text(
                                      "${snapshot.data![index].productName}"),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "jumlah : ${snapshot.data![index].quantity}"),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.deleteCart(
                                                snapshot.data![index].id);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                ),
                            separatorBuilder: (_, index) => const SizedBox(),
                            itemCount: snapshot.data!.length),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                minimumSize: const Size.fromHeight(45)),
                            onPressed: () async {
                              await controller.addToTransaction(
                                snapshot.data!,
                              );
                              // Get.toNamed(Routes.TRANSACTION_SUCCESS,
                              //     arguments: {"cart": snapshot.data!});
                            },
                            child: const Text('Pesan'),
                          ),
                        ),
                      ])))
              : const Center(
                  child: Text('Keranjang Kosong'),
                );
        },
      )),
    );
  }
}
