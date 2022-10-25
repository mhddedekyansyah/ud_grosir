import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/product_model.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/read_product_controller.dart';

class ReadProductView extends GetView<ReadProductController> {
  const ReadProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<ProductModel>>(
      stream: controller.fetchProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
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
                    child: ListView(
                        children: snapshot.data
                            ?.map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(15),
                                  leading: e.imgUrl != null
                                      ? Image.network(
                                          '${e.imgUrl}',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/images/bonbon.png',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                  tileColor: Colors.white,
                                  title: Text("${e.name}"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            Get.toNamed(Routes.EDIT_PRODUCT,
                                                arguments: {'product': e});
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            controller
                                                .deleteProduct(e.id)
                                                .then((_) => Get.back());
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList() as List<Widget>)))
            : Center(child: Text('produk kosong'));
      },
    ));
  }
}
