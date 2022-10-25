import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:ud_grosir/app/routes/app_pages.dart';

class VerifyController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController smsCode = TextEditingController(text: '');
  late Timer _timer;
  final RxInt _start = 30.obs;
  final RxBool _resend = false.obs;
  String? verificationId;

  int get start => _start.value;
  bool get resend => _resend.value;
  String setSmsCode(String code) => smsCode.text = code;

  @override
  void onInit() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_start.value == 0) {
        _start.value = 30;
        _resend.value = true;
        timer.cancel();
      } else {
        _start.value--;
      }
    });

    super.onInit();
  }

  Future<void> signUp(
      String mobile, String smsCode, String verificationId) async {
    try {
      _auth.verifyPhoneNumber(
          phoneNumber: mobile,
          verificationCompleted: (PhoneAuthCredential credential) async {
            CollectionReference userRef =
                FirebaseFirestore.instance.collection('users');
            UserCredential user = await _auth.signInWithCredential(credential);
            DocumentSnapshot data = await userRef.doc(user.user?.uid).get();

            if (data.data() != null) {
              Get.offAllNamed(Routes.HOME);
            } else {
              Get.offAllNamed(Routes.FORM_REGISTER);
            }
          },
          verificationFailed: (FirebaseAuthException e) async {
            // if (e.code == 'invalid-phone-number') {
            //   Get.snackbar('Failed', 'invalid phone number',
            //       backgroundColor: Colors.red,
            //       snackPosition: SnackPosition.TOP,
            //       duration: const Duration(seconds: 3));
            // }
          },
          codeSent: (String verificationId, int? resendToken) async {
            verificationId = verificationId;
            // Get.snackbar(
            //   'succes',
            //   'OTP code has been sent',
            //   backgroundColor: Colors.green,
            //   snackPosition: SnackPosition.TOP,
            // );
            // Get.offAllNamed(Routes.VERIFY, arguments: {
            //   'phoneNumber': mobile,
            //   'verificationId': verificationId
            // });
          },
          timeout: const Duration(seconds: 30),
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId = verificationId;
            // Auto-resolution timed out...
          });
    } catch (e) {
      throw e;
    }
  }

  Future<void> verify(
    String verificationId,
  ) async {
    print(smsCode.text);
    print('verificationId => $verificationId');
    try {
      UserCredential user = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode.text));

      if (user.credential != null) {}
      CollectionReference userRef =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot data = await userRef.doc(user.user?.phoneNumber).get();

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
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-verification-code') {
        Get.snackbar('Failed', 'kode otp salah',
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3));
      } else if (e.code == 'session-expired') {
        Get.snackbar('Failed', 'kode otp telah expired',
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3));
      }
    }
  }
}
