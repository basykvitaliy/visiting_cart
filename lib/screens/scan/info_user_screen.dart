
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/screens/scan/scan_controller.dart';
import 'package:visiting_card/widgets/button_loading_widget.dart';
import 'package:visiting_card/widgets/button_widget.dart';

class InfoUserScreen extends GetView<ScanController> {
  const InfoUserScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 10,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: AppColors.mainColor,
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProfileAvatar(
                          '',
                          borderColor: AppColors.whiteColor,
                          borderWidth: 1,
                          elevation: 1,
                          radius: 80,
                          backgroundColor: AppColors.hintTextColor,
                          child: Image.network(''),
                        ),

                      ],
                    ),

                    const SizedBox(height: 24),
                    Column(
                      children: [
                        Obx(() => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: ButtonLoadingWidget(
                            height: 50,
                            textButton: "save".tr.toUpperCase(),
                            isDisabledBtn: true,
                            isChangeBtn: true,
                            large: controller.isLargeAnim.value,
                            onTap:(){
                              controller.isLargeAnim.value = true;

                            },
                          ),
                        )),
                        const SizedBox(height: 8),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: ButtonWidget(
                            height: 50,
                            title: "cansel".tr.toUpperCase(),
                            isDisabledBtn: true,
                            onTap: () => Get.back(),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
