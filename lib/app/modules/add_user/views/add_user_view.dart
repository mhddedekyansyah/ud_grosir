import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';

import '../controllers/add_user_controller.dart';

class AddUserView extends GetView<AddUserController> {
  const AddUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tambah Toko'),
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
                                children: [
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
                                children: [
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
                    child: GetBuilder<AddUserController>(
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
                              decoration: BoxDecoration(
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
                    Text(
                      'Nama Toko',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Pemilik Toko',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (String name) {
                        print(name);
                        controller.setNameToko(name);
                      },
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat Toko',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (String address) {
                        print(address);
                        controller.setAddress(address);
                      },
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(.5), blurRadius: 3)
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
                          image: DecorationImage(
                              image: AssetImage('assets/icons/id.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        '+62',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: controller.phoneNumberC,
                          autofocus: true,
                          showCursor: true,
                          cursorHeight: 18,
                          keyboardType: TextInputType.phone,
                          cursorColor: Colors.black,
                          autocorrect: false,
                          maxLength: 12,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            counterText: '',
                            hintText: '819-5727-9663',
                            hintStyle: TextStyle(
                                letterSpacing: 2,
                                fontSize: 18,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          onChanged: (_) {
                            print(controller.phoneNumberC.text);
                            controller.setValid(controller.phoneNumberC.text);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (controller.image != null) {
                      await controller.uploadFile().then((_) async {
                        await controller.addGrosir();
                        await controller.addUser();
                        Get.offAllNamed(Routes.ADMIN_HOME);
                      });
                    } else {
                      Get.snackbar('Oops!!', 'Gambar Toko Harus Diisi',
                          backgroundColor: Colors.red);
                    }
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
