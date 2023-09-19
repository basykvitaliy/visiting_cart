import 'package:uuid/uuid.dart';

enum BottomNavTabs {
  main,
  notification,
  add,
  peoples,
  profile,
}
enum SingingCharacter {
  male,
  female,
  other,
}
enum Social {
  pinterest,
  youtube,
  twitter,
  facebook,
  telegram,
  whatsapp,
  instagram,
  behance,
  linkedin,
}
enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  unknown,
  error,
  firebaseError
}

class LayoutConstants {
  static const snackBarRadius = 10.0;
}

class Keys {
  static const isDarkTheme = "isDarkTheme";
  static const deviceId = "deviceId";
  static const token = "token";
  static const uId = "uId";
  static const color = "color";
  static const cardKey = "cardKey";
  static const barcodeSvg = "barcodeSvg";
  static const qrCodeSvg = "qrCodeSvg";
}
