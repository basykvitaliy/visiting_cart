import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/screens/scan/scan_controller.dart';
import 'package:visiting_card/widgets/scan_screen_widget.dart';

import 'info_user_screen.dart';

class ScanScreen extends GetView<ScanController> {
  ScanScreen({Key? key}) : super(key: key);

  @override
  final ScanController controller = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme().colors!.secondColors,
        automaticallyImplyLeading: false,
        title: Text('scanCard'.tr.toUpperCase(),
          style: AppStyles.boldWhiteHeading,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      backgroundColor: AppTheme().colors!.mainBackground,
      body: Obx(() =>
          controller.barcodeMainValue.value == '' ? ScanSreenWidget(controller: controller) : const InfoUserScreen()),
    );
  }
}
