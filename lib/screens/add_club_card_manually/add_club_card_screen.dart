
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/helpers/constants.dart';
import 'package:visiting_card/routes/routes.dart';
import 'package:visiting_card/widgets/button_widget.dart';

import 'add_club_card_controller.dart';

class AddClubCardScreen extends GetView<AddClubCardController> {
  AddClubCardScreen({Key? key}) : super(key: key);

  @override
  final AddClubCardController controller = Get.put(AddClubCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "addClubCard".tr,
          style: AppStyles.boldWhiteHeading,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: AppTheme().colors!.secondColors,
      ),
      backgroundColor: AppTheme().colors!.mainBackground,
      body: Form(
        key: controller.formKey,
        child: Obx(
          () => Container(
            margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.addLogoScreen),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.secondColor),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: controller.isLoadImage.value
                            ? Image.file(controller.image.value, fit: BoxFit.cover)
                            : Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: AppColors.secondColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.cardNameController,
                      keyboardType: TextInputType.text,
                      style: AppTheme().styles!.textStyle16WhiteColor,
                      validator: (value) {
                        if (!controller.isCardName(value!)) {
                          controller.isValidName.value = false;
                        } else {
                          controller.isValidName.value = true;
                        }
                        return null;
                      },
                      onChanged: (v) {
                        if (v.length >= 3) {
                          controller.isValidName.value = true;
                        } else {
                          controller.isValidName.value = false;
                        }
                      },
                      decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: "cardName".tr,
                          hintText: "cardName".tr,
                          hintStyle: AppTheme().styles!.hintStyle16,
                          border: const UnderlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: AppTheme().styles!.textStyle16WhiteColor,
                      controller: controller.barcodeController,
                      validator: (value) {
                        if (!controller.isBarcode(value!)) {
                          controller.isValidName.value = false;
                        } else {
                          controller.isValidName.value = true;
                        }
                        return null;
                      },
                      onChanged: (v) {
                        if (v.length >= 5) {
                          controller.isValidName.value = true;
                        } else {
                          controller.isValidName.value = false;
                        }
                      },
                      decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: "barcode".tr,
                          hintText: "barcode".tr,
                          hintStyle: AppTheme().styles!.hintStyle16,
                          suffixIcon: InkWell(onTap: () => Get.toNamed(Routes.scanScreen), child: const Icon(Icons.qr_code_scanner)),
                          border: const UnderlineInputBorder()),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ButtonWidget(
                      height: 50,
                      title: "save".tr.toUpperCase(),
                      isDisabledBtn: true,
                      onTap: () {
                        controller.saveNewPersonCard().then((value) {
                          if (value == AuthStatus.successful) {
                            Get.back();
                            Get.back();
                            Get.forceAppUpdate();
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    ButtonWidget(
                      height: 50,
                      title: "cansel".tr.toUpperCase(),
                      isDisabledBtn: true,
                      onTap: () => Get.back(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
