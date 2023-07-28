import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/screens/favorite/favorite_screen.dart';
import 'package:visiting_card/screens/home/home_screen.dart';
import 'package:visiting_card/screens/menu/menu_controller.dart';
import 'package:visiting_card/screens/settings/settings_screen.dart';


class MenuScreen extends GetView<MenuController> {
  MenuScreen({Key? key}) : super(key: key);

  @override
  final MenuController controller = Get.put(MenuController());
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.bgLayout,
        body: _buildScreens()[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          type: BottomNavigationBarType.fixed,
          onTap: (index) async {
            controller.selectedIndex.value = index;
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.mainColor,
          selectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(bottom: 6),
                child: const Icon(
                  Icons.home_outlined,
                  color: AppColors.gray,
                  size: 27,
                ),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.only(bottom: 6),
                child: const Icon(
                  Icons.home,
                  color: AppColors.mainColor,
                  size: 27,
                ),
              ),
              label: "notifications".tr,
            ),
            BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: const Icon(
                    Icons.favorite_border,
                    color: AppColors.gray,
                    size: 27,
                  ),
                ),
                activeIcon: Container(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: const Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                    size: 27,
                  ),
                ),
                label: "scan".tr),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(bottom: 6),
                child: const Icon(
                  Icons.settings,
                  color: AppColors.gray,
                  size: 27,
                ),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.only(bottom: 6),
                child: const Icon(
                  Icons.settings_outlined,
                  color: AppColors.mainColor,
                  size: 27,
                ),
              ),
              label: "profile".tr,
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _buildScreens() {
  return [
    HomeScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];
}
