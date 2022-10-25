import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/transaction_model.dart';
import 'package:ud_grosir/app/modules/splash/views/splash_view.dart';
import 'package:ud_grosir/app/modules/transaction/views/transaction_view.dart';
import 'package:ud_grosir/app/modules/user_home/views/user_home_view.dart';

import '../controllers/main_home_user_controller.dart';

class MainHomeUserView extends GetView<MainHomeUserController> {
  const MainHomeUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainHomeUserController>(
        builder: (controller) => Scaffold(
              body: IndexedStack(
                index: controller.tabIndex,
                children: [UserHomeView(), TransactionView()],
              ),
              // bottomNavigationBar: BottomNavigationBar(
              //     onTap: (index) => controller.changeTabIndex(index),
              //     unselectedItemColor: Colors.grey[700],
              //     selectedItemColor: Colors.white,
              //     showSelectedLabels: false,
              //     showUnselectedLabels: false,
              //     iconSize: 30,
              //     backgroundColor: Colors.black,
              //     type: BottomNavigationBarType.fixed,
              //     items: [
              //       BottomNavigationBarItem(
              //           icon: Icon(Icons.home), label: 'home'),
              //       BottomNavigationBarItem(
              //           icon: Icon(Icons.work_history), label: 'transaction'),
              //     ]),
              bottomNavigationBar: BottomAppBar(
                child: Container(
                  height: 100.0,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            controller.changeTabIndex(0);
                          },
                          icon: Icon(Icons.home, color: Colors.white)),
                      StreamBuilder<List<TransactionModel>>(
                          stream: controller.fetchTransaction(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('something went wrong'),
                              );
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Badge(
                              badgeContent: Text((snapshot.data != null
                                      ? snapshot.data!
                                          .where((e) => e.status == 'DIPROSES')
                                          .length
                                      : '')
                                  .toString()),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.wallet,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  controller.changeTabIndex(1);
                                },
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            ));
  }
}
