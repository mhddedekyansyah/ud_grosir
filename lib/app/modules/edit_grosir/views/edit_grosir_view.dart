import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ud_grosir/app/data/models/grosir_model.dart';

import '../controllers/edit_grosir_controller.dart';

class EditGrosirView extends GetView<EditGrosirController> {
  GrosirModel grosir = Get.arguments['grosir'];
  EditGrosirController controller = Get.put(EditGrosirController());
  EditGrosirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Grosir'),
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
                            const SizedBox(height: 10),
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
                    child: grosir.imgUrl!.isNotEmpty
                        ? GetBuilder<EditGrosirController>(
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
                                                '${grosir.imgUrl}'),
                                            fit: BoxFit.cover))),
                          )
                        : GetBuilder<EditGrosirController>(
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
                      'Nama Toko',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: grosir.name,
                      onChanged: (String name) {
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
                    Text('Nama Pemilik Toko',
                        style: GoogleFonts.poppins(fontSize: 18)),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: grosir.ownerToko,
                      onChanged: (String name) {
                        controller.setOwner(name);
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
                      'Alamat',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: grosir.address,
                      onChanged: (String num) {
                        controller.setAddress(num);
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
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'No.Hp',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    blurRadius: 3)
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 30,
                                height: 20,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        spreadRadius: .5,
                                        blurRadius: .5),
                                  ],
                                  borderRadius: BorderRadius.circular(3),
                                  image: const DecorationImage(
                                      image: AssetImage('assets/icons/id.png'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              const Text(
                                '+62',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Flexible(
                                child: TextFormField(
                                  controller: controller.mobileC,
                                  showCursor: true,
                                  cursorHeight: 18,
                                  keyboardType: TextInputType.phone,
                                  cursorColor: Colors.black,
                                  autocorrect: false,
                                  maxLength: 12,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    counterText: '',
                                    hintText: '819-5727-9663',
                                    hintStyle: TextStyle(
                                        letterSpacing: 2,
                                        fontSize: 18,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w500),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                  onChanged: (_) {
                                    controller
                                        .setValid(controller.mobileC!.text);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (controller.image != null) {
                      await controller.uploadFile().then(
                          (_) async => await controller.updateGrosir(grosir));
                      Get.back();
                    } else {
                      await controller.updateGrosir(grosir);
                      Get.back();
                    }
                  },
                  child: const Text(
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
