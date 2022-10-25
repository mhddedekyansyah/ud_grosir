import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductController controller = Get.put(AddProductController());
  AddProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tambah Produk'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.all(30),
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
                        padding: EdgeInsets.all(15),
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
                    child: GetBuilder<AddProductController>(
                      builder: (controller) => controller.image != null
                          ? Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      image: FileImage(
                                          File(controller.image!.path)),
                                      fit: BoxFit.cover)))
                          : Container(
                              width: 110,
                              height: 110,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/icons/pic.png')))),
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
                        print(name);
                        controller.setName(name);
                      },
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
                        print(num.runtimeType);
                        controller.setPrice(num);
                      },
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
                        print(num);
                        controller.setStock(num);
                      },
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
                        print(desc);
                        controller.setDesc(desc);
                      },
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
                MaterialButton(
                  onPressed: () async {
                    if (controller.image == null) {
                      Get.snackbar('Oops!!', 'Gambar Produk harus diisi',
                          backgroundColor: Colors.red);
                      return;
                    }
                    await controller
                        .uploadFile()
                        .then((_) async => await controller.addProduct());
                    Get.back();
                  },
                  child: Text(
                    'Tambah',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
