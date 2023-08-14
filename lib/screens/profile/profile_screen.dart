import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/routes/routes.dart';
import 'package:visiting_card/screens/profile/profile_controller.dart';

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
          automaticallyImplyLeading: false,
          backgroundColor: AppTheme().colors!.secondColors,
        ),
        backgroundColor: AppTheme().colors!.mainBackground,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              SignInButton(
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
          ),
        ));
  }
}
