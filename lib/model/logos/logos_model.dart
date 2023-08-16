class LogosModel {

  String? title;
  String? image;
  String? backgroundColor;

  LogosModel({
      this.title,
      this.image,
      this.backgroundColor,
  });

  LogosModel.fromJson(dynamic json) {
    title = json['title'];
    image = json['logo'];
    backgroundColor = json['backgroundColor'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['logo'] = image;
    map['backgroundColor'] = backgroundColor;
    return map;
  }

}