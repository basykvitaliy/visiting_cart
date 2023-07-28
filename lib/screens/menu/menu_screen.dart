import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/routes/routes.dart';
import 'package:visiting_card/screens/favorite/favorite_screen.dart';
import 'package:visiting_card/screens/home/home_screen.dart';
import 'package:visiting_card/screens/menu/menu_main_controller.dart';
import 'package:visiting_card/screens/profile/profile_screen.dart';
import 'package:visiting_card/screens/settings/settings_screen.dart';

class MenuScreen extends GetView<MenuMainController> {
  MenuScreen({Key? key}) : super(key: key);

  @override
  final MenuMainController controller = Get.put(MenuMainController());
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
        onWillPop: controller.onWillPop,
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: AppTheme().colors!.mainBackground,
          body: _buildScreens()[controller.selectedIndex.value],
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme().colors!.secondColors,
            child: Icon(Icons.camera_alt_outlined),
            onPressed: () => Get.toNamed(Routes.scanScreen),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            shadow: BoxShadow(
              blurRadius: 7,
              offset: -Offset(2, 2),
              color: AppTheme().colors!.shadowOne,
            ),
            borderColor: AppColors.secondDarkThemeColor.withOpacity(0.3),
            borderWidth: 3,
            blurEffect: true,
            activeColor: AppColors.whiteColor,
            inactiveColor: AppTheme().colors!.secondColorsDisable,
            activeIndex: controller.selectedIndex.value,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 10,
            rightCornerRadius: 10,
            onTap: (index) async {
              controller.selectedIndex.value = index;
            },
            backgroundColor: AppTheme().colors!.secondColors,
            elevation: 0,
            icons: iconList,
          ),
        )));
  }
}
final iconList = <IconData>[
  Icons.home,
  Icons.favorite,
  Icons.settings,
  Icons.person,
];

List<Widget> _buildScreens() {
  return [
    HomeScreen(),
    FavoriteScreen(),
    SettingsScreen(),
    ProfileScreen(),
  ];
}
