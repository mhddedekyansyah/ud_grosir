import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/product_model.dart';

import '../controllers/edit_product_controller.dart';

class EditProductView extends GetView<EditProductController> {
  ProductModel product = Get.arguments['product'];
  EditProductController controller = Get.put(EditProductController());
  EditProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Produk'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(30),
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      Get.bottomSheet(Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(15),
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await controller.pickFromCamera();
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.camera),
                                  SizedBox(width: 10),
                                  Text('from camera')
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () async {
                                await controller.pickFromGalley();
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.image),
                                  SizedBox(width: 10),
                                  Text('from gallery')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
                    },
                    child: product.imgUrl != null
                        ? GetBuilder<EditProductController>(
                            builder: (controller) => controller.image != null
                                ? Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: DecorationImage(
                                            image: FileImage(File(
                                                '${controller.image!.path}')),
                                            fit: BoxFit.cover)))
                                : Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${product.imgUrl}'),
                                            fit: BoxFit.cover))),
                          )
                        : GetBuilder<EditProductController>(
                            builder: (controller) => controller.image != null
                                ? Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: DecorationImage(
                                            image: FileImage(File(
                                                '${controller.image!.path}')),
                                            fit: BoxFit.cover)))
                                : Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/icons/pic.png'),
                                            fit: BoxFit.cover))),
                          )),
                const SizedBox(
                  height: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nama Produk',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (String name) {
                        controller.setName(name);
                      },
                      initialValue: product.name,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Harga',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (String num) {
                        controller.setPrice(num);
                      },
                      initialValue: product.price.toString(),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Stok',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (String num) {
                        controller.setStock(num);
                      },
                      initialValue: product.stock.toString(),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Deskripsi',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (String desc) {
                        controller.setDesc(desc);
                      },
                      initialValue: product.description,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (controller.image != null) {
                      await controller
                          .uploadFile()
                          .then((_) async => controller.updateProduct(product));
                      Get.back();
                    } else {
                      await controller.updateProduct(product);
                      Get.back();
                    }
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
