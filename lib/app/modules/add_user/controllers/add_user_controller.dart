import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/grosir_model.dart';
import 'package:ud_grosir/app/data/models/user_model.dart';
import 'package:ud_grosir/app/services/grosir_service.dart';
import 'package:ud_grosir/app/services/user_service.dart';
import 'package:image_picker/image_picker.dart';

class AddUserController extends GetxController {
  final TextEditingController phoneNumberC = TextEditingController(text: '');
  final user = FirebaseAuth.instance.currentUser;
  FirebaseStorage storage = FirebaseStorage.instance;
  UploadTask? uploadTask;
  TextEditingController nameC = TextEditingController(text: '');
  TextEditingController addressC = TextEditingController(text: '');
  TextEditingController nameTokoC = TextEditingController(text: '');
  XFile? image;
  String? imgUrl;
  ImagePicker? _picker;

  String validPhoneNumber = '';

  void setValid(String num) {
    validPhoneNumber = '+62${phoneNumberC.text}';
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

  void setName(String name) => nameC.text = name;
  void setNameToko(String name) => nameTokoC.text = name;
  void setAddress(String address) => addressC.text = address;

  Future<void> uploadFile() async {
    final path = 'images/${image!.name}';
    final file = File(image!.path);
    final ref = storage.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    imgUrl = urlDownload;
  }

  Future<UserModel> addUser() async {
    try {
      UserModel userModel = UserModel(
          id: validPhoneNumber,
          name: nameC.text,
          address: addressC.text,
          role: 'grosir',
          photoUrl: imgUrl,
          mobile: validPhoneNumber);
      await UserServices().setUser(userModel);

      return userModel;
    } catch (e) {
      throw e;
    }
  }

  Future<GrosirModel> addGrosir() async {
    try {
      GrosirModel grosirModel = GrosirModel(
          id: validPhoneNumber,
          userId: validPhoneNumber,
          ownerToko: nameTokoC.text,
          name: nameC.text,
          address: addressC.text,
          imgUrl: imgUrl,
          mobile: validPhoneNumber);
      await GrosirServices().setGrosir(grosirModel);

      return grosirModel;
    } catch (e) {
      throw e;
    }
  }
}
