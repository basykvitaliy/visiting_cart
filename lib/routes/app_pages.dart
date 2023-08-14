import 'package:get/get.dart';
import 'package:visiting_card/model/my_card/card_model.dart';
import 'package:visiting_card/routes/routes.dart';
import 'package:visiting_card/screens/add_club_card_manually/add_club_card_screen.dart';
import 'package:visiting_card/screens/add_club_card_manually/add_logo_screen/add_logo_card_screen.dart';
import 'package:visiting_card/screens/favorite/favorite_binding.dart';
import 'package:visiting_card/screens/favorite/favorite_screen.dart';
import 'package:visiting_card/screens/home/home_binding.dart';
import 'package:visiting_card/screens/home/home_screen.dart';
import 'package:visiting_card/screens/pay/pay_binding.dart';
import 'package:visiting_card/screens/pay/pay_screen.dart';
import 'package:visiting_card/screens/profile/profile_screen.dart';
import 'package:visiting_card/screens/scan/info_card_screen.dart';
import 'package:visiting_card/screens/scan/scan_binding.dart';
import 'package:visiting_card/screens/scan/scan_screen.dart';
import 'package:visiting_card/screens/settings/settings_binding.dart';
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
      page: () => InfoCardScreen(cardModel: CardModel(),),
    ),
    GetPage(
      name: Routes.settingsScreen,
      page: () => SettingsScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.enterDataManuallyScreen,
      page: () => AddClubCardScreen(),
    ),
    GetPage(
      name: Routes.payScreen,
      page: () => PayScreen(),
      binding: PayBinding(),
    ),
    GetPage(
      name: Routes.addLogoScreen,
      page: () => AddLogoCardScreen(),
    ),
    GetPage(
      name: Routes.profileScreen,
      page: () => ProfileScreen(),
    ),
  ];
}
