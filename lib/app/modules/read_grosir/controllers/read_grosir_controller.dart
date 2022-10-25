import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/grosir_model.dart';

class ReadGrosirController extends GetxController {
  Stream<List<GrosirModel>> fetchGrosir() async* {
    try {
      dynamic grosir = FirebaseFirestore.instance
          .collection('grosirs')
          .snapshots()
          .map((event) => event.docs
              .map((e) => GrosirModel.fromJson(e.id, e.data()))
              .toList());
      yield* grosir;
    } catch (e) {
      print(e);
    }
  }

  CollectionReference grosir = FirebaseFirestore.instance.collection('grosirs');
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  Future<void> deleteGrosir(dynamic uid) {
    return grosir
        .doc(uid)
        .delete()
        .then((value) => print("Grosir Deleted"))
        .catchError((error) => print("Failed to delete grosir: $error"));
  }

  Future<void> deleteUser(dynamic uid) {
    return user
        .doc(uid)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
