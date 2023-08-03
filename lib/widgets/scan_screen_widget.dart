import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/routes/routes.dart';
import 'package:visiting_card/screens/scan/scan_controller.dart';

import 'button_widget.dart';


class ScanSreenWidget extends StatelessWidget {
  const ScanSreenWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ScanController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only( left: 16, right: 16, bottom: 16),
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: controller.buildQrView(context),
                  ),
                ),
                Obx(() => Positioned(
                  bottom: 24,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      controller.toggleIsFlash();
                      await controller.controllerQr.toggleFlash();
                    },
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: controller.isFlash.value
                          ? Icon(Icons.flashlight_on, color: AppColors.whiteColor,)
                          : Icon(Icons.flashlight_off_sharp, color: AppColors.whiteColor,),

                    ),
                  ),
                )),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ButtonWidget(
                height: 50,
                title: "cansel".tr.toUpperCase(),
                isDisabledBtn: true,
                onTap: () => Get.back(),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
