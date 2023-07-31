import 'dart:typed_data';

class UserModel {

  int? id;
  String? name;
  String? phone;
  Uint8List? photo;
  String? email;
  String? birthday;
  String? qrcode;

  UserModel({
    this.id,
      this.name,
      this.phone, 
      this.photo, 
      this.email, 
      this.birthday,
      this.qrcode,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    photo = json['photo'];
    email = json['email'];
    birthday = json['birthday'];
    qrcode = json['qrcode'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['photo'] = photo;
    map['email'] = email;
    map['birthday'] = birthday;
    map['qrcode'] = qrcode;
    return map;
  }

}