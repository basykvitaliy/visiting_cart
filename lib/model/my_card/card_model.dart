import 'dart:typed_data';

class CardModel {
  int? id;
  String? cardName;
  String? barcode;
  String? date;
  String? backgroundColor;
  Uint8List? photo;

  CardModel({
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

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardName = json['cardName'];
    barcode = json['barcode'];
    date = json['date'];
    backgroundColor = json['backgroundColor'];
    photo = json['photo'];
  }
}
