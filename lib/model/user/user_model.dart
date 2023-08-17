

class UserModel {

  int? id;
  String? name;
  String? photo;
  String? email;

  UserModel({
    this.id,
      this.name,
      this.photo, 
      this.email,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    email = json['email'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['photo'] = photo;
    map['email'] = email;
    return map;
  }

}