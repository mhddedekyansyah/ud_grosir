import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/product_model.dart';
import 'package:ud_grosir/app/services/product_service.dart';
import 'package:image_picker/image_picker.dart';

class EditProductController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  FirebaseStorage storage = FirebaseStorage.instance;
  UploadTask? uploadTask;
  TextEditingController? nameC = TextEditingController();
  TextEditingController? description = TextEditingController();
  TextEditingController? stockc = TextEditingController();
  TextEditingController? priceC = TextEditingController();
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

    if (img != null) {
      image = img;
      update();
      Get.back();
    }
  }

  // setter
  void setName(String name) => nameC?.text = name;
  void setDesc(String desc) => description?.text = desc;
  void setStock(String stock) => stockc?.text = stock;
  void setPrice(String price) => priceC?.text = price;

  Future<void> uploadFile() async {
    final path = 'product/${image!.name}';
    final file = File(image!.path);
    final ref = storage.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    imgUrl = urlDownload;
  }

  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      ProductModel productModel = ProductModel().copyWith(
        id: product.id,
        grosirId: product.grosirId,
        name: nameC!.text.isEmpty ? product.name : nameC!.text,
        imgUrl: imgUrl ?? product.imgUrl,
        stock: stockc!.text.isEmpty ? product.stock : stockc!.text as int,
        price: priceC!.text.isEmpty ? product.price : priceC!.text as int,
        description:
            description!.text.isEmpty ? product.description : description!.text,
      );
      await ProductServices().updateProduct(productModel);
      return productModel;
    } catch (e) {
      throw e;
    }
  }
}
