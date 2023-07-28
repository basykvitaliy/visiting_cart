import 'package:get/get.dart';
import 'package:visiting_card/routes/routes.dart';
import 'package:visiting_card/screens/home/home_binding.dart';
import 'package:visiting_card/screens/home/home_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
