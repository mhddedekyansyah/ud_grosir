import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () async {
      // Get.toNamed(Routes.REGISTER);
      User? user = FirebaseAuth.instance.currentUser;
      CollectionReference userRef =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot data = await userRef.doc(user?.phoneNumber).get();
      if (user != null) {
        if (data.data() != null) {
          Map<String, dynamic> role = data.data() as Map<String, dynamic>;

          if (role['role'] == 'admin') {
            Get.offAllNamed(Routes.ADMIN_HOME);
          } else if (role['role'] == 'supplier') {
            Get.offAllNamed(Routes.MAIN_HOME_USER);
          } else if (role['role'] == 'grosir') {
            Get.offAllNamed(Routes.HOME_GROSIR);
          }
        }
      } else {
        Get.toNamed(Routes.REGISTER);
      }
    });
    super.onInit();
  }
}
