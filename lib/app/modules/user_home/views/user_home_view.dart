import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ud_grosir/app/data/models/cart_model.dart';
import 'package:ud_grosir/app/data/models/grosir_model.dart';
import 'package:ud_grosir/app/data/models/product_model.dart';
import 'package:ud_grosir/app/data/models/user_model.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';

import '../controllers/user_home_controller.dart';

class UserHomeView extends GetView<UserHomeController> {
  UserHomeController grosirC = Get.put(UserHomeController());
  UserHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder<UserModel>(
                      stream: controller.fetchUser(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          controller.user = snapshot.data;
                          return Row(
                            children: [
                              controller.user!.photoUrl != null
                                  ? Container(
                                      width: 60.0,
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${controller.user!.photoUrl}'),
                                              fit: BoxFit.cover)),
                                    )
                                  : Container(
                                      width: 60.0,
                                      height: 60.0,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icons/user_photo_null.png'),
                                              fit: BoxFit.cover)),
                                    ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text('${controller.user!.name}')
                            ],
                          );
                        }
                        return const Text('no data');
                      }),
                  Row(
                    children: [
                      StreamBuilder<List<CartModel>>(
                          stream: controller.cart(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Badge(
                              badgeContent: snapshot.data != null
                                  ? Text(snapshot.data!.length.toString())
                                  : const Text('0'),
                              child: IconButton(
                                icon: const Icon(Icons.shopping_cart),
                                onPressed: () {
                                  Get.toNamed(Routes.CART);
                                },
                              ),
                            );
                          }),
                      const SizedBox(
                        width: 15,
                      ),
                      IconButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Get.offAllNamed(Routes.REGISTER);
                          },
                          icon: const Icon(Icons.logout))
                    ],
                  )
                ],
              ),
              StreamBuilder<List<GrosirModel>>(
                  stream: grosirC.fetchGrosir(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return snapshot.data!.isNotEmpty
                        ? Expanded(
                            child: Container(
                            width: double.infinity,
                            child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 20),
                                itemBuilder: (context, index) => InkWell(
                                      onTap: () => Get.toNamed(
                                          Routes.GROSIR_PRODUCT,
                                          arguments: {
                                            'grosirId':
                                                snapshot.data?[index].mobile,
                                            'user': controller.user
                                          }),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  color: Colors.grey
                                                      .withOpacity(.5))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    '${snapshot.data?[index].imgUrl}'),
                                                fit: BoxFit.cover)),
                                        child: Text(
                                            '${snapshot.data?[index].name}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                letterSpacing: 2.5)
                                            // TextStyle(
                                            //     fontSize: 30,
                                            //     fontWeight: FontWeight.bold,
                                            //     letterSpacing: 2.5),
                                            ),
                                      ),
                                    ),
                                separatorBuilder: (_, index) => const SizedBox(
                                      height: 10,
                                    ),
                                itemCount: snapshot.data!.length),
                          ))
                        : const Text('grosir masih kosong');
                  })
            ],
          ),
        ),
      )),
    );
  }
}
