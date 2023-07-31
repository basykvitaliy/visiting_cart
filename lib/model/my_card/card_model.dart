
import 'dart:typed_data';

import 'package:visiting_card/model/my_card/social_networks.dart';
import 'address_model.dart';

class CardModel {
  int? id;
  int? type;
  String? nameUser;
  String? companyName;
  String? profession;
  String? phone;
  String? email;
  AddressModel? address;
  List<SocialNetworks>? socialNetworks = [];
  String? logo;
  String? backgroundColor;
  Uint8List? photo;
  int? isFavorite;

  CardModel({
    this.id,
    this.type,
    this.nameUser,
    this.companyName,
    this.profession,
    this.phone,
    this.email,
    this.address,
    this.socialNetworks,
    this.logo,
    this.backgroundColor,
    this.photo,
    this.isFavorite,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['nameUser'] = nameUser;
    map['companyName'] = companyName;
    map['profession'] = profession;
    map['phone'] = phone;
    map['email'] = email;
    map['address'] = address?.toJson();
        if (socialNetworks != null) {
      map['socialNetworks'] = socialNetworks?.map((v) => v.toJson()).toList();
    }
    map['logo'] = logo;
    map['backgroundColor'] = backgroundColor;
    map['photo'] = photo;
    map['isFavorite'] = isFavorite;
    return map;
  }


  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    nameUser = json['nameUser'];
    companyName = json['companyName'];
    profession = json['profession'];
    phone = json['phone'];
    email = json['email'];
    address = AddressModel.fromJson(json['address']);
        if (json['socialNetworks'] != null) {
      socialNetworks =
      List<SocialNetworks>.from(json['socialNetworks'].map((x) => SocialNetworks.fromJson(x)));
    }
    logo = json['logo'];
    backgroundColor = json['backgroundColor'];
    photo = json['photo'];
    isFavorite = json['isFavorite'];
  }

}
