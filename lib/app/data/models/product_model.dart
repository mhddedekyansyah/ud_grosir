import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String? id;
  final String? grosirId;
  final String? name;
  final String? imgUrl;
  final int? price;
  final int? stock;
  final String? description;

  const ProductModel(
      {this.id,
      this.grosirId,
      this.name,
      this.imgUrl = '',
      this.description,
      this.price,
      this.stock});

  ProductModel copyWith({
    String? id,
    String? grosirId,
    String? name,
    String? imgUrl,
    int? price,
    int? stock,
    String? description,
  }) =>
      ProductModel(
          id: id ?? this.id,
          grosirId: grosirId ?? this.grosirId,
          name: name ?? this.name,
          imgUrl: imgUrl ?? this.imgUrl,
          price: price ?? this.price,
          stock: stock ?? this.stock,
          description: description ?? this.description);

  factory ProductModel.fromJson(String id, Map<String, dynamic> json) =>
      ProductModel(
          id: id,
          grosirId: json['grosirId'],
          name: json['name'],
          imgUrl: json['imgUrl'],
          price: json['price'],
          stock: json['stock'],
          description: json['description']);
  @override
  List<Object?> get props =>
      [id, grosirId, name, imgUrl, price, stock, description];
}
