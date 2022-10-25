import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/grosir_model.dart';
import 'package:ud_grosir/app/services/grosir_service.dart';
import 'package:image_picker/image_picker.dart';

class EditGrosirController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  FirebaseStorage storage = FirebaseStorage.instance;
  UploadTask? uploadTask;
  TextEditingController? nameC = TextEditingController(text: '');
  TextEditingController? ownerC = TextEditingController(text: '');
  TextEditingController? addressC = TextEditingController(text: '');
  TextEditingController? mobileC = TextEditingController(text: '');
  XFile? image;
  String? imgUrl;
  ImagePicker? _picker;

  String validPhoneNumber = '';

  void setValid(String num) {
    validPhoneNumber = '+62${mobileC?.text}';
  }

  @override
  void onInit() {
    _picker = ImagePicker();
    super.onInit();
  }

  Future<void> pickFromGalley() async {
    final XFile? img = await _picker!.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    print(img?.path);
    if (img != null) {
      image = img;
      update();
      Get.back();
    }
  }

  Future<void> pickFromCamera() async {
    final XFile? img = await _picker!.pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
    print(img?.path);
    if (img != null) {
      image = img;
      update();
      Get.back();
    }
  }

  // setter
  void setName(String name) => nameC?.text = name;
  void setOwner(String owner) => ownerC?.text = owner;
  void setAddress(String adderss) => addressC?.text = adderss;
  void setMonile(String mobile) => mobileC?.text = mobile;

  Future<void> uploadFile() async {
    final path = 'grosir/${image!.name}';
    final file = File(image!.path);
    final ref = storage.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    imgUrl = urlDownload;
  }

  Future<GrosirModel> updateGrosir(GrosirModel grosir) async {
    print('image => ${imgUrl}');

    try {
      GrosirModel grosirModel = GrosirModel().copyWith(
        id: grosir.id,
        userId: grosir.mobile,
        name: nameC!.text.isEmpty ? grosir.name : nameC!.text,
        imgUrl: imgUrl ?? grosir.imgUrl,
        ownerToko: ownerC!.text.isEmpty ? grosir.ownerToko : ownerC!.text,
        address: addressC!.text.isEmpty ? grosir.address : addressC!.text,
        mobile: mobileC!.text.isEmpty ? grosir.mobile : mobileC!.text,
      );
      await GrosirServices().updateGrosir(grosirModel);
      return grosirModel;
    } catch (e) {
      throw e;
    }
  }
}
