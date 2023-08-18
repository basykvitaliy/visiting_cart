import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/screens/scan/scan_controller.dart';
import 'package:visiting_card/widgets/button_widget.dart';

class ScanScreen extends GetView<ScanController> {
  ScanScreen({Key? key}) : super(key: key);

  @override
  final ScanController controller = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme().colors!.secondColors,
        automaticallyImplyLeading: true,
        title: Text('scanCard'.tr,
          style: AppStyles.boldWhiteHeading,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      backgroundColor: AppTheme().colors!.mainBackground,
      body: Center(
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
                      child: QRView(
                        key: controller.qrKey,
                        onQRViewCreated: controller.onQRViewCreated,
                        overlay: QrScannerOverlayShape(
                          borderColor: AppColors.secondColor,
                          borderRadius: 10,
                          borderLength: 20,
                          borderWidth: 10,
                          cutOutHeight: 250,
                          cutOutWidth: MediaQuery.of(context).size.width / 1.3,
                        ),
                        onPermissionSet: (ctrl, p) => controller.onPermissionSet(context, ctrl, p),
                      ),
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
      ),
    );
  }
}
