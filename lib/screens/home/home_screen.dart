import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:visiting_card/ad/ad_mob.dart';
import 'package:visiting_card/ad/reusable_inline_example.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/helpers/constants.dart';
import 'package:visiting_card/routes/routes.dart';
import 'package:visiting_card/screens/scan/info_card_screen.dart';
import 'package:visiting_card/widgets/card_widget.dart';

import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  @override
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    controller.getCardList();
    return Scaffold(
      backgroundColor: AppTheme().colors!.mainBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.enterDataManuallyScreen),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 175,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset('assets/images/bg_card.png'),
                    title: Text(
                      "myCards".tr,
                      style: AppStyles.boldWhiteHeading,
                    ),
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
                Obx(() => SliverList(
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                      return GestureDetector(
                        onLongPress: () {
                          controller.deleteCard(controller.cardList[index].id.toString());
                          controller.getCardList();
                          Get.showSnackbar(GetSnackBar(
                            titleText: Text("success".tr, style: AppStyles.regularWhiteText16),
                            messageText: Text("youBusinessCardIsDelete".tr, style: AppStyles.regularWhiteText16),
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(milliseconds: 1500),
                            backgroundColor: AppTheme().colors!.secondColors,
                            borderRadius: LayoutConstants.snackBarRadius,
                          ));
                        },
                        child: OpenContainer(
                          transitionType: _transitionType,
                          openBuilder: (BuildContext context, VoidCallback _) {
                            return InfoCardScreen(cardModel: controller.cardList[index]);
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
                              model: controller.cardList[index],
                            );
                          },
                        ),
                      );
                    }, childCount: controller.cardList.length))),
              ],
            ),
          ),
          controller.bannerAd != null
              ? Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: controller.bannerAd!.size.width.toDouble(),
                    height: controller.bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: controller.bannerAd!),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
