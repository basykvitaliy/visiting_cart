import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/screens/profile/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  var controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme().colors!.mainBackground,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppBar(
              title: Text(
                "myAccount".tr.toUpperCase(),
                style: AppTheme().styles!.bold22,
              ),
              centerTitle: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                controller.isShowEditButton.value ? GestureDetector(
                  child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      color: Colors.transparent,
                      child: Icon(
                        Icons.edit,
                        color: AppTheme().isLightTheme ? AppColors.mainTextColor : AppColors.whiteColor,
                        size: 20,
                      )),
                ) : const SizedBox()
              ],
              backgroundColor: AppTheme().colors!.mainBackground,
            ),
            CircularProfileAvatar(
              '',
              borderColor: AppColors.whiteColor,
              borderWidth: 1,
              elevation: 1,
              radius: 80,
              backgroundColor: AppColors.hintTextColor,
              child: const Icon(Icons.person),
            ),
            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                ],
              ),
            ),

          ],
        ));
  }
}


