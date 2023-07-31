
class SocialNetworks {

  String? socialLink;
  String? socialName;

  SocialNetworks({
    this.socialLink,
    this.socialName,
  });

  SocialNetworks.fromJson(Map<String, dynamic> json){
     socialLink = json['socialLink'];
     socialName = json['socialName'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['socialLink'] = socialLink;
    map['socialName'] = socialName;
    return map;
  }
}