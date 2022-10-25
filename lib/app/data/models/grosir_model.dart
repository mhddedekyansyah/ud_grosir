import 'package:equatable/equatable.dart';

class GrosirModel extends Equatable {
  final String? id;
  final String? userId;
  final String? ownerToko;
  final String? name;
  final String? address;
  final String? mobile;
  final String? imgUrl;

  const GrosirModel(
      {this.id,
      this.userId,
      this.ownerToko,
      this.name,
      this.address,
      this.mobile,
      this.imgUrl = ''});

  GrosirModel copyWith({
    String? id,
    String? userId,
    String? ownerToko,
    String? name,
    String? address,
    String? mobile,
    String? imgUrl,
  }) =>
      GrosirModel(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          ownerToko: ownerToko ?? ownerToko,
          imgUrl: imgUrl ?? this.imgUrl,
          name: name ?? this.name,
          address: address ?? this.address,
          mobile: mobile ?? this.mobile);

  factory GrosirModel.fromJson(String id, Map<String, dynamic> json) =>
      GrosirModel(
          id: id,
          userId: json['userId'],
          ownerToko: json['owner_toko'],
          name: json['name'],
          address: json['address'],
          mobile: json['mobile'],
          imgUrl: json['imgUrl']);

  @override
  List<Object?> get props =>
      [id, userId, ownerToko, address, name, mobile, imgUrl];
}
