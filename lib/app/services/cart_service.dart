import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ud_grosir/app/data/models/cart_model.dart';

class CartService {
  CollectionReference cartRef = FirebaseFirestore.instance.collection('carts');

  Future<void> setCart(CartModel cart) async {
    try {
      cartRef.add({
        'userId': cart.userId,
        'productId': cart.productId,
        'grosirId': cart.grosirId,
        'productName': cart.productName,
        'userName': cart.userName,
        'address': cart.address,
        'quantity': cart.quantity,
        'total': cart.total,
        'imgUrl': cart.imgUrl
      }).then((value) => print('add to cart success'));
    } catch (e) {
      throw e;
    }
  }
}
