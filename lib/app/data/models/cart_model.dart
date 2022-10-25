import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  String? id;
  String? userId;
  String? productId;
  String? grosirId;
  String? productName;
  String? userName;
  String? address;
  int? quantity;
  int? total;
  String? imgUrl;

  CartModel(
      {this.id,
      this.userId,
      this.productId,
      this.grosirId,
      this.productName,
      this.userName,
      this.address,
      this.quantity,
      this.total,
      this.imgUrl});

  factory CartModel.fromJson(String id, Map<String, dynamic> json) => CartModel(
      id: id,
      userId: json['userId'],
      productId: json['productId'],
      grosirId: json['grosirId'],
      productName: json['productName'],
      userName: json['userName'],
      address: json['address'],
      quantity: json['quantity'],
      total: json['total'],
      imgUrl: json['imgUrl']);
  @override
  List<Object?> get props => [
        id,
        userId,
        productId,
        productName,
        quantity,
        total,
        imgUrl,
        address,
        userName
      ];
}
