import 'dart:typed_data';

class CardFBModel {
  String? id;
  String? cardName;
  String? barcode;
  String? date;
  String? backgroundColor;
  String? photo;

  CardFBModel({
    this.id,
    this.cardName,
    this.barcode,
    this.date,
    this.backgroundColor,
    this.photo,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['cardName'] = cardName;
    map['barcode'] = barcode;
    map['date'] = date;
    map['backgroundColor'] = backgroundColor;
    map['photo'] = photo;
    return map;
  }

  CardFBModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardName = json['cardName'];
    barcode = json['barcode'];
    date = json['date'];
    backgroundColor = json['backgroundColor'];
    photo = json['photo'];
  }
}
