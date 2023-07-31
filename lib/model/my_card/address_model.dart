class AddressModel {
  String? city;
  String? street;
  String? house;
  String? office;

  AddressModel({
    this.city,
    this.street,
    this.house,
    this.office,
  });

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'street': street,
      'house': house,
      'office': office,
    };
  }

  AddressModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    street = json['street'];
    house = json['house'];
    office = json['office'];
  }
}

