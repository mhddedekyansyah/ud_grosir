import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ud_grosir/app/data/models/user_model.dart';

class UserServices {
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel userModel) async {
    try {
      _userRef.doc(userModel.id).set({
        'userId': userModel.mobile,
        'name': userModel.name,
        'address': userModel.address,
        'role': userModel.role,
        'mobile': userModel.mobile,
        'photoUrl': userModel.photoUrl
      });
      // Get.offAllNamed(Routes.USER_HOME);
    } catch (e) {
      throw e;
    }
  }
}
