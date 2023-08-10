
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/helpers/constants.dart';
import 'package:visiting_card/widgets/button_widget.dart';

import 'add_personal_card_controller.dart';

class AddPersonalCardScreen extends GetView<AddPersonalCardController> {
  AddPersonalCardScreen({Key? key}) : super(key: key);

  @override
  final AddPersonalCardController controller = Get.put(AddPersonalCardController());

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 32, top: 16),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Obx(
              () => Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const SizedBox(height: 16),
                 Column(
                          children: [
                            CircularProfileAvatar(
                              '',
                              borderColor: AppColors.secondColor,
                              borderWidth: 1,
                              elevation: 1,
                              radius: 60,
                              backgroundColor: AppColors.mainColor,
                              child: controller.isLoadImage.value
                                  ? Image.file(controller.image.value, fit: BoxFit.cover)
                                  : Icon(
                                      Icons.camera_alt,
                                      size: 40,
                                      color: AppColors.secondColor.withOpacity(0.5),
                                    ),
                              onTap: () {
                                controller.showImageSourceDialog(context);
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                  controller: controller.nameController,
                                  keyboardType: TextInputType.text,
                                  style: AppTheme().styles!.textStyle16WhiteColor,
                                  validator: (value) {
                                    if (!controller.isName(value!)) {
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
                                      labelText: "name".tr,
                                      hintText: "name".tr,
                                      hintStyle: AppTheme().styles!.hintStyle16,
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: AppColors.errorColor,
                                            width: 1,
                                          )),
                                      border: const UnderlineInputBorder())),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                  controller: controller.companyNameController,
                                  keyboardType: TextInputType.text,
                                  style: AppTheme().styles!.textStyle16WhiteColor,
                                  validator: (value) {
                                    if (!controller.isName(value!)) {
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
                                      labelText: "companyName".tr,
                                      hintText: "companyName".tr,
                                      hintStyle: AppTheme().styles!.hintStyle16,
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: AppColors.errorColor,
                                            width: 1,
                                          )),
                                      border: const UnderlineInputBorder())),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                controller: controller.professionController,
                                keyboardType: TextInputType.text,
                                style: AppTheme().styles!.textStyle16WhiteColor,
                                decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    labelText: "profession".tr,
                                    hintText: "profession".tr,
                                    hintStyle: AppTheme().styles!.hintStyle16,
                                    border: const UnderlineInputBorder()),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                controller: controller.phoneController,
                                keyboardType: TextInputType.phone,
                                style: AppTheme().styles!.textStyle16WhiteColor,
                                validator: (value) {
                                  if (!controller.isPhone(value!)) {
                                    controller.isValidPhone.value = false;
                                  } else {
                                    controller.isValidPhone.value = true;
                                  }
                                  return null;
                                },
                                onChanged: (v) {
                                  if (v.length >= 13) {
                                    controller.isValidPhone.value = true;
                                  } else {
                                    controller.isValidPhone.value = false;
                                  }
                                },
                                onTap: () {
                                  controller.phoneController.text = "+38";
                                },
                                decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    labelText: "phoneNumber".tr,
                                    hintText: "phoneNumber".tr,
                                    hintStyle: AppTheme().styles!.hintStyle16,
                                    border: const UnderlineInputBorder()),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                controller: controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: AppTheme().styles!.textStyle16WhiteColor,
                                decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    labelText: "email".tr,
                                    hintText: "email".tr,
                                    hintStyle: AppTheme().styles!.hintStyle16,
                                    border: const UnderlineInputBorder()),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: ButtonWidget(
                                height: 50,
                                title: "save".tr.toUpperCase(),
                                isDisabledBtn: true,
                                onTap: (){
                                  controller.saveNewPersonCard().then((value){
                                    if(value == AuthStatus.successful) {
                                      Get.back();
                                      Get.back();
                                    }
                                  });
                                } ,
                              ),
                            )
                          ],
                        )

                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
