import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/widgets/button_widget.dart';

class MenuController extends GetxController with GetTickerProviderStateMixin {
  static MenuController get to => Get.find();
  RxInt selectedIndex = 0.obs;

  Future<bool> onWillPop() async {
    return (await showDialog(
      context: Get.context!,
      builder: (context) => Center(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: SizedBox(
            width: Get.width / 1.3,
            height: 200,
            child: Scaffold(
              backgroundColor: AppColors.mainColor,
              body: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("doYouWantToExit".tr, style: AppStyles.boldHeading22,),
                      ButtonWidget(
                        title: "Ok",
                        height: 50,
                        isDisabledBtn: true,
                        onTap: () => pop(),
                      ),
                      ButtonWidget(
                        title: "cansel".tr,
                        height: 50,
                        isDisabledBtn: true,
                        onTap: () => Get.back(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    )) ??
        false;
  }

  static Future<void> pop({bool? animated}) async {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
