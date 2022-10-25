import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ud_grosir/app/data/models/product_model.dart';
import 'package:ud_grosir/app/data/models/user_model.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  ProductModel product = Get.arguments['product'];
  UserModel user = Get.arguments['user'];
  CheckoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print('User From current page => ${Get.arguments['user']}');
    return Scaffold(
        body: Stack(
      children: [
        (product.imgUrl!.isNotEmpty
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 30, left: 15),
                height: 280,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    image: DecorationImage(
                        image: NetworkImage('${product.imgUrl}'),
                        fit: BoxFit.cover)),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Get.back(),
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 30, left: 15),
                height: 280,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    image: DecorationImage(
                        image: AssetImage('assets/images/bonbon.png'),
                        fit: BoxFit.cover)),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Get.back(),
                  ),
                ),
              )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 24, 15, 24),
            width: double.infinity,
            height: 550,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Stack(
              children: [
                ListView(padding: const EdgeInsets.only(bottom: 80), children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${product.name}',
                        style: GoogleFonts.poppins(
                            fontSize: 24, fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp.',
                                    decimalDigits: 0)
                                .format(int.parse(product.price.toString())),
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => controller.quantity.value <= 1
                                    ? SizedBox()
                                    : IconButton(
                                        onPressed: () {
                                          controller.minusQuantity(
                                              1, product.price as int);
                                        },
                                        icon: Icon(Icons.remove)),
                              ),
                              Obx(
                                () => Text(controller.quantity.toString()),
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (product.stock == 0) {
                                      return;
                                    }
                                    controller.addQuantity(
                                        1, product.price as int);
                                  },
                                  icon: Icon(Icons.add)),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        'Stok',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      Text(
                        '${product.stock}',
                        style: GoogleFonts.poppins(color: Colors.grey),
                      ),
                      Text(
                        'Deskripsi',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      Text(
                        '${product.description}',
                        style: GoogleFonts.poppins(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Total',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      Obx(
                        () => Text(
                          '${controller.total.value == 0 ? NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0).format(int.parse(product.price.toString())) : NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0).format(int.parse(controller.total.value.toString()))}',
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  )
                ]),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (product.stock == 0) {
                          return;
                        }
                        await controller
                            .addToCart(product, user)
                            .then((value) => {
                                  print(
                                      'add to cart success ${value.productName}'),
                                  Get.toNamed(Routes.MAIN_HOME_USER)
                                });
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: Get.width / 20),
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        'Masukkan Keranjang',
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      )),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (product.stock == 0) {
                          return;
                        }
                        await controller
                            .addToTransaction(product, Get.arguments['user'])
                            .then((_) =>
                                {Get.offAllNamed(Routes.MAIN_HOME_USER)});
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: Get.width / 20),
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        'Beli Sekarang',
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      )),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
