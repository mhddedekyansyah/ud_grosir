import 'package:equatable/equatable.dart';


class UserModel extends Equatable {
  String? id;
  String? name;
  String? address;
  String? mobile;
  String? role;
  String? photoUrl;

  UserModel(
      {required this.id,
      required this.name,
      required this.address,
      required this.mobile,
      required this.role,
      this.photoUrl = ''});

  factory UserModel.fromJson(String id, Map<String, dynamic> json) => UserModel(
      id: id,
      name: json['name'],
      address: json['address'],
      mobile: json['mobile'],
      role: json['role'],
      photoUrl: json['photoUrl']);

  @override
  List<Object?> get props => [id, name, address, mobile, role, photoUrl];
}
