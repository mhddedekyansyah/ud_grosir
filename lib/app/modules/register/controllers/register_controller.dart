import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ud_grosir/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final TextEditingController phoneNumberC = TextEditingController(text: '');
  String? documentId;
  String validPhoneNumber = '';

  void setValid(String num) {
    validPhoneNumber = '+62${phoneNumberC.text}';
  }

  Future<void> signUp() async {
    try {
      _auth.verifyPhoneNumber(
          phoneNumber: validPhoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            CollectionReference userRef =
                FirebaseFirestore.instance.collection('users');
            UserCredential user = await _auth.signInWithCredential(credential);
            print("userPhoneNumber => ${user.user?.phoneNumber}");
            DocumentSnapshot data =
                await userRef.doc(user.user?.phoneNumber).get();
            if (data.data() != null) {
              Map<String, dynamic> role = data.data() as Map<String, dynamic>;

              if (role['role'] == 'admin') {
                Get.offAllNamed(Routes.ADMIN_HOME);
              } else if (role['role'] == 'supplier') {
                Get.offAllNamed(Routes.MAIN_HOME_USER);
              } else if (role['role'] == 'grosir') {
                Get.offAllNamed(Routes.HOME_GROSIR);
              }
            } else {
              Get.offAllNamed(Routes.FORM_REGISTER);
            }
          },
          verificationFailed: (FirebaseAuthException e) async {
            print(e.code);
            if (e.code == 'invalid-phone-number') {
              Get.snackbar('Failed', 'invalid phone number',
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 3));
            } else if (e.code == 'too-many-requests') {
              Get.defaultDialog(
                  title: 'Oops!',
                  textConfirm: 'Ok',
                  onConfirm: () => Get.back(),
                  titlePadding: const EdgeInsets.all(15.0),
                  content: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/bonbon.png',
                          width: 150,
                          height: 150,
                        ),
                        const Text(
                          'request otp terlalu sering coba beberapa saat lagi',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ));
            }
          },
          codeSent: (String verificationId, int? resendToken) async {
            print(verificationId);
            Get.snackbar(
              'sukses',
              'Kode OTP telah dikirim',
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.TOP,
            );
            Get.offAllNamed(Routes.VERIFY, arguments: {
              'phoneNumber': validPhoneNumber,
              'verificationId': verificationId,
            });
          },
          timeout: const Duration(seconds: 30),
          codeAutoRetrievalTimeout: (String verificationId) {
            // Auto-resolution timed out...
          });
    } catch (e) {
      print(e);
    }
  }
}
