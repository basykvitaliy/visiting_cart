
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/routes/routes.dart';
import 'package:visiting_card/screens/scan/info_user_screen.dart';
import 'package:visiting_card/widgets/card_widget.dart';

import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  @override
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().colors!.mainBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 165,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/images/bgcard.png'),
              title: Text("My cards", style: AppStyles.boldWhiteHeading,),
              expandedTitleScale: 2,
              centerTitle: true,
            ),
            backgroundColor: AppTheme().colors!.secondColors,
            actions: [
              GestureDetector(
                onTap: () => Get.toNamed(Routes.settingsScreen),
                child: Container(margin: const EdgeInsets.only(right: 8), child: Icon(Icons.settings, color: AppColors.whiteColor)),
              )
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                return OpenContainer(
                  transitionType: _transitionType,
                  openBuilder: (BuildContext context, VoidCallback _) {
                    return InfoUserScreen();
                  },
                  closedElevation: 0.0,
                  closedColor: AppColors.mainColor,
                  closedShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  transitionDuration: const Duration(milliseconds: 700),
                  closedBuilder: (BuildContext context, VoidCallback openContainer) {
                    return CardWidget(
                      favorite: () => controller.toggleFavorite(),
                      isFavorite: controller.isFavorite.value,
                    );
                  },
                );
              }, childCount: 5)),
        ],
      ),
    );
  }
}


