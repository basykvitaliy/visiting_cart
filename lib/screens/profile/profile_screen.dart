
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/screens/home/home_controller.dart';
import 'package:visiting_card/screens/profile/profile_controller.dart';
import 'package:visiting_card/services/firebase_services.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  var controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "profile".tr,
            style: AppStyles.boldWhiteHeading,
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: AppTheme().colors!.secondColors,
          actions: [
            IconButton(onPressed: () => FirebaseServices().signOut().whenComplete(() {
              controller.isBuyer.value = false;
              controller.deleteUser(controller.user.value);
              HomeController.to.cardList.clear();
              Get.forceAppUpdate();
            }), icon: Icon(Icons.exit_to_app))
          ],
        ),
        backgroundColor: AppTheme().colors!.mainBackground,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  controller.isBuyer.value
                      ? Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CircleAvatar(
                              radius: 40,
                              child: Image.network(controller.user.value.photo.toString()),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(controller.user.value.name.toString(), style: AppStyles.regularWhiteHeading18,),
                          const SizedBox(height: 16),
                          Text(controller.user.value.email.toString(), style: AppStyles.regularWhiteHeading18,)
                        ],
                      )
                      : SignInButton(
                          Buttons.Google,
                          text: "Sign up with Google",
                          onPressed: () => controller.signInWithGoogle(),
                        ),
                  SizedBox(
                    height: 50,
                    child: controller.bannerAd != null
                        ? Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: controller.bannerAd!.size.width.toDouble(),
                              height: controller.bannerAd!.size.height.toDouble(),
                              child: AdWidget(ad: controller.bannerAd!),
                            ),
                          )
                        : Container(),
                  ),
                ],
              )),
        ));
  }
}
