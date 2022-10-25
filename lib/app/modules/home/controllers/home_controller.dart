import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';

class HomeController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _auth.signOut().then((value) => print('signOut'));
    Get.toNamed(Routes.REGISTER);
  }
}
