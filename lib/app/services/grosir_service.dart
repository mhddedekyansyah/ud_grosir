import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/grosir_model.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';

class GrosirServices {
  final CollectionReference _grosirRef =
      FirebaseFirestore.instance.collection('grosirs');

  Future<void> setGrosir(GrosirModel grosirModel) async {
    try {
      _grosirRef.doc(grosirModel.id).set({
        'name': grosirModel.name,
        'owner_toko': grosirModel.ownerToko,
        'address': grosirModel.address,
        'mobile': grosirModel.mobile,
        'imgUrl': grosirModel.imgUrl
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateGrosir(GrosirModel grosirModel) async {
    try {
      _grosirRef.doc(grosirModel.id).update({
        'name': grosirModel.name,
        'owner_toko': grosirModel.ownerToko,
        'address': grosirModel.address,
        'mobile': grosirModel.mobile,
        'imgUrl': grosirModel.imgUrl
      });
    } catch (e) {
      throw e;
    }
  }
}
