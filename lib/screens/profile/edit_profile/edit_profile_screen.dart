import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/screens/profile/profile_controller.dart';

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
            "myAccount".tr.toUpperCase(),
            style: AppTheme().styles!.bold22,
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
                margin: const EdgeInsets.only(right: 12),
                color: Colors.transparent,
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: AppTheme().isLightTheme ? AppColors.mainTextColor : AppColors.whiteColor,
                  size: 20,
                )),
          ),
          backgroundColor: AppTheme().colors!.mainBackground,
        ),
        backgroundColor: AppTheme().colors!.mainBackground,
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [

                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                controller: controller.nameController,
                                keyboardType: TextInputType.text,
                                style:controller.isValidName.value ? AppTheme().styles!.textStyle16WhiteColor : AppStyles.regularErrorText16,
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
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                    alignLabelWithHint: true,
                                    hintText: "firstName".tr,
                                    hintStyle: controller.isValidName.value ? AppTheme().styles!.hintStyle16 : AppStyles.regularErrorText16,
                                    border: const OutlineInputBorder(borderSide: BorderSide.none)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [

                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                controller: controller.lastNameController,
                                keyboardType: TextInputType.text,
                                style: AppTheme().styles!.textStyle16WhiteColor,
                                // validator: (value) {
                                //   if (!controller.isEmail(value!)) {
                                //     controller.isValidEmail.value = false;
                                //     return 'Please enter a valid email';
                                //   } else {
                                //     controller.isValidEmail.value = true;
                                //     return null;
                                //   }
                                // },
                                // onChanged: (v) {
                                //   if (v.length >= 12) {
                                //     controller.isDisabled.value = true;
                                //   } else {
                                //     controller.isDisabled.value = false;
                                //     controller.isValid.value = true;
                                //   }
                                // },
                                decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: "lastName".tr,
                                    hintStyle: AppTheme().styles!.hintStyle16,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: AppColors.errorColor,
                                          width: 1,
                                        )),
                                    border: const OutlineInputBorder(borderSide: BorderSide.none)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [

                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                controller: controller.birthDayController,
                                onTap: () => controller.handleDatePicker(context),
                                keyboardType: TextInputType.text,
                                style: AppTheme().styles!.textStyle16WhiteColor,
                                readOnly: true,
                                decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: "dateOfBirth".tr,
                                    hintStyle: AppTheme().styles!.hintStyle16,

                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: AppColors.errorColor,
                                          width: 1,
                                        )),
                                    border: const OutlineInputBorder(borderSide: BorderSide.none)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [

                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                controller: phone?.text == null ? controller.phoneController : phone,
                                keyboardType: TextInputType.phone,
                                style:controller.isValidPhone.value ? AppTheme().styles!.textStyle16WhiteColor : AppStyles.regularErrorText16,
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
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                    alignLabelWithHint: true,
                                    hintText: "phoneNumber".tr,
                                    hintStyle: controller.isValidPhone.value ? AppTheme().styles!.hintStyle16 : AppStyles.regularErrorText16,
                                    border: const OutlineInputBorder(borderSide: BorderSide.none)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [

                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                controller: controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: AppTheme().styles!.textStyle16WhiteColor,
                                // validator: (value) {
                                //   if (!controller.isEmail(value!)) {
                                //     controller.isValidEmail.value = false;
                                //     return 'Please enter a valid email';
                                //   } else {
                                //     controller.isValidEmail.value = true;
                                //     return null;
                                //   }
                                // },
                                // onChanged: (v) {
                                //   if (v.length >= 12) {
                                //     controller.isDisabled.value = true;
                                //   } else {
                                //     controller.isDisabled.value = false;
                                //     controller.isValid.value = true;
                                //   }
                                // },
                                decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: "email".tr,
                                    hintStyle: AppTheme().styles!.hintStyle16,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: AppColors.errorColor,
                                          width: 1,
                                        )),
                                    border: const OutlineInputBorder(borderSide: BorderSide.none)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ));
  }
}
