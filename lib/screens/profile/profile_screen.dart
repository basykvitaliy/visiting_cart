import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            "Profile",
            style: AppStyles.boldWhiteHeading,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppTheme().colors!.secondColors,
          actions: [ controller.isShowEditButton.value ?
            GestureDetector(
              onTap: () => Get.toNamed(Routes.editProfileScreen),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.edit,
                  color: AppColors.whiteColor,
                ),
              ),
            ) : Container()
          ],
        ),
        backgroundColor: AppTheme().colors!.mainBackground,
        body: FutureBuilder(
            future: controller.getUser(),
            builder: (context, snapshot) {
              var user = snapshot.data;
              if (snapshot.connectionState != ConnectionState.waiting) {
                if (snapshot.hasData) {
                  controller.isShowEditButton.value = true;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 32, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircularProfileAvatar(
                          '',
                          borderColor: AppColors.whiteColor,
                          borderWidth: 1,
                          elevation: 1,
                          radius: 80,
                          backgroundColor: AppColors.hintTextColor,
                          child: user!.photo != null ? Image.memory(user.photo!, fit: BoxFit.cover) : const Icon(Icons.person),
                        ),
                        Text(user.name.toString(), style: AppTheme().styles!.bold20),
                        Text("The section is available for authorized users", style: AppTheme().styles!.textStyle16WhiteColor),
                        const SizedBox(height: 16),
                        TextButton(onPressed: () {}, child: Text("Pay", style: AppTheme().styles!.textStyle16mainColor))
                        // QrImage(
                        //   foregroundColor: AppTheme().colors!.secondColors,
                        //   data: 'Test user qr',
                        //   version: QrVersions.auto,
                        //   size: 320,
                        //   gapless: false,
                        // ),
                      ],
                    ),
                  );
                } else {
                  controller.isShowEditButton.value = false;
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You don't have any cards yet", style: AppTheme().styles!.textStyle16WhiteColor),
                        const SizedBox(height: 16),
                        TextButton(onPressed: () => Get.toNamed(Routes.editProfileScreen), child: Text("Create card", style: AppTheme().styles!.textStyle16mainColor))
                      ],
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
