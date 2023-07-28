
class Session {
  static Session _instance = Session._internal();
  static String? authToken;
  static String? uId;
  static String? shopId;
  factory Session() => _instance;

  Session._internal() {
    _instance = this;
  }

  factory Session.create(String token,  String uId, String shopId) {
    authToken = token;
    uId = uId;
    shopId = shopId;
    return _instance;
  }

  factory Session.fromMap(Map<String, dynamic> m) {
    authToken = m['authToken'] as String;
    uId = m['uId'] as String;
    shopId = m['shopId'] as String;
    return _instance;
  }

  static bool get hasAuthToken => authToken != null;
  static bool get hasUId => uId != null;
  static bool get hasShopId => shopId != null;

  static Map<String, Object> toMap() {
    return {
      'authToken': authToken as String,
      'uId': uId as String,
      'shopId': shopId as String,
    };
  }
}
