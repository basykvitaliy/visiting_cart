import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/screens/scan/info_user_screen.dart';
import 'package:visiting_card/widgets/card_widget.dart';

import 'favorite_controller.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  FavoriteScreen({Key? key}) : super(key: key);
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite", style: AppStyles.boldWhiteHeading,),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme().colors!.secondColors,
      ),
      backgroundColor: AppTheme().colors!.mainBackground,
      body: ListView.builder(
        itemCount: 5,
          itemBuilder: (context, index){
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
              favorite: () {},
              isFavorite: true,
            );
          },
        );
      }),
    );
  }
}
