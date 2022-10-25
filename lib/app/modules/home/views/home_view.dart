import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Home'),
                SizedBox(height: 100),
                InkWell(
                    onTap: () async {
                      await controller.signOut();
                    },
                    child: Text('SignOut')),
                SizedBox(
                  height: 100,
                ),
                // InkWell(
                //     onTap: () async {
                //       await FirebaseAuth.instance.signOut();
                //       Get.toNamed(Routes.REGISTER);
                //     },
                //     child: Text('logout'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
