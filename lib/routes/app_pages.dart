import 'package:get/get.dart';
import 'package:visiting_card/routes/routes.dart';
import 'package:visiting_card/screens/favorite/favorite_binding.dart';
import 'package:visiting_card/screens/favorite/favorite_screen.dart';
import 'package:visiting_card/screens/home/home_binding.dart';
import 'package:visiting_card/screens/home/home_screen.dart';
import 'package:visiting_card/screens/scan/info_user_screen.dart';
import 'package:visiting_card/screens/scan/scan_binding.dart';
import 'package:visiting_card/screens/scan/scan_screen.dart';
import 'package:visiting_card/screens/settings/settings_binding.dart';
import 'package:visiting_card/screens/settings/settings_controller.dart';
import 'package:visiting_card/screens/settings/settings_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.scanScreen,
      page: () => ScanScreen(),
      binding: ScanBinding(),
    ),
    GetPage(
      name: Routes.favoriteScreen,
      page: () => FavoriteScreen(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: Routes.infoScreen,
      page: () => InfoUserScreen(),
    ),
    GetPage(
      name: Routes.settingsScreen,
      page: () => SettingsScreen(),
      binding: SettingsBinding(),
    ),
  ];
}
