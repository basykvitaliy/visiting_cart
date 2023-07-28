import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/routes/routes.dart';
import 'package:visiting_card/screens/scan/scan_controller.dart';

import 'button_icon_widget.dart';
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.3,
        margin: const EdgeInsets.only(top: 50, bottom: 16, left: 16, right: 16),
        decoration: BoxDecoration(
            color: AppTheme().colors!.mainBackground, borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('scanQrCode'.tr.toUpperCase(),
                  style: AppTheme().styles!.bold22,
                  textAlign: TextAlign.center,
                ),
            Container(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: controller.buildQrView(context),
              ),
            ),
           Obx(() => ButtonIconWidget(
             width: MediaQuery.of(context).size.width / 1.2,
             height: 50,
             icon: controller.isFlash.value
                 ? SvgPicture.asset(
               "assets/svg/flash_on.svg",
               width: 30,
             )
                 : SvgPicture.asset(
               "assets/svg/flash_off.svg",
               width: 30,
             ),
             isDisabledBtn: true,
             onTap: () async {
               controller.toggleIsFlash();
               await controller.controllerQr.toggleFlash();
             },
           )),
            Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonWidget(
                      height: 50,
                      title: "enterDataManually".tr.toUpperCase(),
                      isDisabledBtn: true,
                      onTap: (){
                        controller.controllerQr.stopCamera();
                      }

                    ),
                  ),
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
        ),
      ),
    );
  }
}
