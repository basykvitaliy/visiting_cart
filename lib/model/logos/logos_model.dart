class LogosModel {

  String? title;
  String? image;

  LogosModel({
      this.title,
      this.image,
  });

  LogosModel.fromJson(dynamic json) {
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['image'] = image;
    return map;
  }

}