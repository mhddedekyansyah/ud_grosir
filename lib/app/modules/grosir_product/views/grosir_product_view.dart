import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/product_model.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';
import 'package:ud_grosir/app/services/product_service.dart';
import 'package:intl/intl.dart';

import '../controllers/grosir_product_controller.dart';

class GrosirProductView extends GetView<GrosirProductController> {
  GrosirProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<ProductModel>>(
      stream: controller.fetchPrdouct(Get.arguments['grosirId']),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return Container(
          margin: const EdgeInsets.only(top: 24),
          child: ListView.separated(
              padding: const EdgeInsets.all(24),
              itemBuilder: (context, index) {
                // return InkWell(
                //   onTap: () => Get.toNamed(Routes.CHECKOUT,
                //       arguments: {'product': snapshot.data?[index]}),
                //   child: Container(
                //     alignment: Alignment.center,
                //     height: 150,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //             spreadRadius: 5,
                //             blurRadius: 7,
                //             color: Colors.grey.withOpacity(.5))
                //       ],
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Image.network(
                //           '${snapshot.data?[index].imgUrl}',
                //           width: 50,
                //           height: 50,
                //           fit: BoxFit.cover,
                //         ),
                //         SizedBox(
                //           width: 20,
                //         ),
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               '${snapshot.data?[index].name}',
                //               style: TextStyle(
                //                   fontSize: 24, fontWeight: FontWeight.bold),
                //             ),
                //             Text(
                //               NumberFormat.currency(
                //                       locale: 'id',
                //                       symbol: 'Rp.',
                //                       decimalDigits: 0)
                //                   .format(int.parse(
                //                       '${snapshot.data?[index].price}')),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // );
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: InkWell(
                      onTap: () => Get.toNamed(Routes.CHECKOUT, arguments: {
                            'product': snapshot.data?[index],
                            'user': Get.arguments['user']
                          }),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        width: Get.width,
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          '${snapshot.data![index].imgUrl}'),
                                      fit: BoxFit.cover)),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${snapshot.data![index].name}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          snapshot.data![index].name!.length >
                                                  10
                                              ? 14
                                              : 24,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp.',
                                            decimalDigits: 0)
                                        .format(int.parse(
                                            '${snapshot.data![index].price}')),
                                    style: const TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox()
                          ],
                        ),
                      )),
                );
              },
              separatorBuilder: (_, index) => SizedBox(
                    height: 15,
                  ),
              itemCount: snapshot.data!.length),
        );
      },
    ));
  }
}
