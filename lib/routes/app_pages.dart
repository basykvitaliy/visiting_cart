import 'package:get/get.dart';
import 'package:visiting_card/routes/routes.dart';
import 'package:visiting_card/screens/enter_data_manually/enter_data_screen.dart';
import 'package:visiting_card/screens/favorite/favorite_binding.dart';
import 'package:visiting_card/screens/favorite/favorite_screen.dart';
import 'package:visiting_card/screens/home/home_binding.dart';
import 'package:visiting_card/screens/home/home_screen.dart';
import 'package:visiting_card/screens/pay/pay_binding.dart';
import 'package:visiting_card/screens/pay/pay_screen.dart';
import 'package:visiting_card/screens/profile/edit_profile/edit_profile_screen.dart';
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
    GetPage(
      name: Routes.enterDataManuallyScreen,
      page: () => EnterDataScreen(),
    ),
    GetPage(
      name: Routes.payScreen,
      page: () => PayScreen(),
      binding: PayBinding(),
    ),
    GetPage(
      name: Routes.editProfileScreen,
      page: () => EditProfileScreen(),
    ),
  ];
}
