import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/product_model.dart';
import 'package:ud_grosir/app/services/product_service.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  FirebaseStorage storage = FirebaseStorage.instance;
  UploadTask? uploadTask;
  TextEditingController nameC = TextEditingController(text: '');
  TextEditingController description = TextEditingController(text: '');
  TextEditingController stockc = TextEditingController(text: '');
  TextEditingController priceC = TextEditingController(text: '');
  XFile? image;
  String? imgUrl;
  ImagePicker? _picker;
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
  void setName(String name) => nameC.text = name;
  void setDesc(String name) => description.text = name;
  void setStock(String stock) => stockc.text = stock;
  void setPrice(String price) => priceC.text = price;

  Future<void> uploadFile() async {
    final path = 'product/${image?.name}';
    final file = File('${image?.path}');
    final ref = storage.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    imgUrl = urlDownload;
  }

  Future<ProductModel> addProduct() async {
    try {
      ProductModel productModel = ProductModel(
        name: nameC.text,
        grosirId: FirebaseAuth.instance.currentUser!.phoneNumber,
        imgUrl: imgUrl,
        description: description.text,
        price: int.parse(priceC.text),
        stock: int.parse(stockc.text),
      );
      print(productModel);
      await ProductServices().setProduct(productModel);
      return productModel;
    } catch (e) {
      throw e;
    }
  }
}
