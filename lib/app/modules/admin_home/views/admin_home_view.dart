import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  AdminHomeController admin = Get.put(AdminHomeController());
  AdminHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                Get.offAllNamed(Routes.REGISTER);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: admin.usersStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Card(
                  margin: EdgeInsets.all(24),
                  color: Colors.blue,
                  child: SizedBox(
                    height: 135,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total User',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${snapshot.data?.docs.length}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 70,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
          StreamBuilder<QuerySnapshot>(
              stream: admin.grosirStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.READ_GROSIR);
                  },
                  child: Card(
                    margin: EdgeInsets.all(24),
                    color: Colors.green,
                    child: SizedBox(
                      height: 135,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Grosir',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${snapshot.data?.docs.length}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.home,
                              color: Colors.white,
                              size: 70,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_USER);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
