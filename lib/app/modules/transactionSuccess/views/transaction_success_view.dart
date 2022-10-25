import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/cart_model.dart';

import '../controllers/transaction_success_controller.dart';

class TransactionSuccessView extends GetView<TransactionSuccessController> {
  const TransactionSuccessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<CartModel> cart = Get.arguments['cart'];
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Transaksi Berhasil'),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    dynamic totals = cart[index].total! * cart.length;
                    debugPrint(totals.toString());
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(cart[index].productName.toString()),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(cart[index].total.toString()),
                          ],
                        ),
                      ],
                    );
                  }),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    primary: Colors.black),
                onPressed: () {},
                child: const Text('Success Transaksi'),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
