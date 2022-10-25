import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  String? id;
  String? userId;
  String? productId;
  String? grosirtId;
  String? productName;
  String status;
  int? quantity;
  int? total;
  String? imgUrl;
  String? userName;
  String? imgUser;
  String? addressUser;
  String? mobileUser;

  TransactionModel(
      {this.id,
      this.userId,
      this.productId,
      this.grosirtId,
      this.status = 'PENDING',
      this.productName,
      this.userName,
      this.imgUser,
      this.addressUser,
      this.mobileUser,
      this.quantity,
      this.total,
      this.imgUrl});

  factory TransactionModel.fromJson(String id, Map<String, dynamic> json) =>
      TransactionModel(
          id: id,
          userId: json['userId'],
          productId: json['productId'],
          grosirtId: json['grosirId'],
          status: json['status'],
          productName: json['productName'],
          quantity: json['quantity'],
          total: json['total'],
          imgUrl: json['imgUrl'],
          userName: json['userName'],
          addressUser: json['userAddress'],
          mobileUser: json['mobileUser'],
          imgUser: json['imgUser']);
  @override
  List<Object?> get props => [
        id,
        userId,
        productId,
        grosirtId,
        status,
        productName,
        userName,
        imgUser,
        addressUser,
        mobileUser,
        quantity,
        total,
        imgUrl
      ];
}
