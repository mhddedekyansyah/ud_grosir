import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  final Stream<QuerySnapshot> grosirStream =
      FirebaseFirestore.instance.collection('grosirs').snapshots();
}
