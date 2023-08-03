import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/routes/routes.dart';
import 'package:visiting_card/screens/favorite/favorite_screen.dart';
import 'package:visiting_card/screens/home/home_screen.dart';
import 'package:visiting_card/screens/menu/menu_main_controller.dart';
import 'package:visiting_card/screens/pay/pay_screen.dart';
import 'package:visiting_card/screens/profile/profile_screen.dart';
import 'package:visiting_card/screens/settings/settings_screen.dart';

class MenuScreen extends GetView<MenuMainController> {
  MenuScreen({Key? key}) : super(key: key);

  @override
  final MenuMainController controller = Get.put(MenuMainController());
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: controller.onWillPop,
      child: PersistentTabView(
        context,
        controller: controller.tabController,
        screens: _buildScreens(),
        items: _navBarsItems(context, controller),
        confineInSafeArea: true,
        backgroundColor: AppColors.secondColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,

        popAllScreensOnTapOfSelectedTab: false,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style12,
      ));
  }
}

List<Widget> _buildScreens() {
  return [
    HomeScreen(),
    PayScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context, MenuMainController controller) {
  return [
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.discount,),
        title: ("homeTitle".tr),
        activeColorPrimary: AppColors.whiteColor,
        inactiveColorPrimary: AppColors.secondDisableColor,
        iconSize: 22),
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.quick_contacts_mail_rounded,),
        title: ("cartTitle".tr),
        activeColorPrimary: AppColors.whiteColor,
        inactiveColorPrimary: AppColors.secondDisableColor,
        iconSize: 22),
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite,),
        title: ("otherTitle".tr),
        activeColorPrimary: AppColors.whiteColor,
        inactiveColorPrimary: AppColors.secondDisableColor,
        iconSize: 22),
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("otherTitle".tr),
        activeColorPrimary: AppColors.whiteColor,
        inactiveColorPrimary: AppColors.secondDisableColor,
        iconSize: 22),
  ];
}
final iconList = <IconData>[
  Icons.discount,
  Icons.person_add_alt_rounded,
  Icons.favorite,
  Icons.person,
];

