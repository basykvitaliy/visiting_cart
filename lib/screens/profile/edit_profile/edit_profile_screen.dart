import 'dart:math';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/screens/profile/profile_controller.dart';
import 'package:visiting_card/widgets/button_widget.dart';

class EditProfileScreen extends GetView<ProfileController> {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  var controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    TextEditingController? phone = Get.arguments as TextEditingController?;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "editAccount".tr,
            style: AppStyles.boldWhiteHeading,
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: true,
          backgroundColor: AppTheme().colors!.secondColors,
        ),
        backgroundColor: AppTheme().colors!.mainBackground,
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 16),
                  Obx(() => Stack(children: [
                        CircularProfileAvatar(
                          '',
                          borderColor: AppColors.whiteColor,
                          borderWidth: 1,
                          elevation: 1,
                          radius: 80,
                          backgroundColor: AppColors.hintTextColor,
                          child: controller.isLoadImage.value ? Image.file(controller.image.value, fit: BoxFit.cover) : const Icon(Icons.person),
                          onTap: () {
                            controller.showImageSourceDialog(context);
                          },
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 12,
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColors.whiteColor.withOpacity(0.5),
                              size: 35,
                            ))
                      ])),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: controller.nameController,
                          keyboardType: TextInputType.text,
                          style:AppTheme().styles!.textStyle16WhiteColor,
                          validator: (value) {
                            if (!controller.isName(value!)) {
                              controller.isValidName.value = false;
                            } else {
                              controller.isValidName.value = true;
                            }
                            return null;
                          },
                          onChanged: (v){
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
                              border: const UnderlineInputBorder())
                        ),
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
                          controller: controller.birthDayController,
                          onTap: () => controller.handleDatePicker(context),
                          keyboardType: TextInputType.text,
                          style: AppTheme().styles!.textStyle16WhiteColor,
                          readOnly: true,
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "dateOfBirth".tr,
                              hintText: "dateOfBirth".tr,
                              hintStyle: AppTheme().styles!.hintStyle16,
                              border: const UnderlineInputBorder()),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: phone?.text == null ? controller.phoneController : phone,
                          keyboardType: TextInputType.phone,
                          style:AppTheme().styles!.textStyle16WhiteColor,
                          validator: (value) {
                            if (!controller.isPhone(value!)) {
                              controller.isValidPhone.value = false;
                            } else {
                              controller.isValidPhone.value = true;
                            }
                            return null;
                          },
                          onChanged: (v){
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
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonWidget(
                      height: 50,
                      title: "save".tr.toUpperCase(),
                      isDisabledBtn: true,
                      onTap: () {
                        controller.saveNewUserToSql();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
