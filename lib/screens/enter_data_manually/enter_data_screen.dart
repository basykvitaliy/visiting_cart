import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/screens/enter_data_manually/enter_data_controller.dart';
import 'package:visiting_card/widgets/button_widget.dart';

class EnterDataScreen extends GetView<EnterDataController> {
  EnterDataScreen({Key? key}) : super(key: key);

  @override
  final EnterDataController controller = Get.put(EnterDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("addDataManually".tr, style: AppStyles.boldWhiteHeading,),
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
            child: Obx(() => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 16),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    width: MediaQuery.of(context).size.width,
                    child: AnimatedToggleSwitch<bool>.dual(
                      current: controller.isLargeAnimation.value,
                      first: false,
                      second: true,
                      borderColor: AppColors.secondColor,
                      borderWidth: 1,
                      height: 50,
                      onChanged: (b) {
                        controller.isLargeAnimation.value  = b;
                      },
                      colorBuilder: (b) => b ? AppColors.secondDarkDisableColor : AppColors.secondColor,
                      iconBuilder: (value) => value
                          ? Icon(Icons.credit_card)
                          : Icon(Icons.person),
                      textBuilder: (value) => value
                          ? Center(child: Text('clubCard'.tr))
                          : Center(child: Text('personal'.tr)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  !controller.isLargeAnimation.value ? Column(
                    children: [
                      CircularProfileAvatar(
                        '',
                        borderColor: AppColors.secondColor,
                        borderWidth: 1,
                        elevation: 1,
                        radius: 60,
                        backgroundColor: AppColors.mainColor,
                        child: controller.isLoadImage.value ? Image.file(controller.image.value, fit: BoxFit.cover) : Icon(Icons.camera_alt, size: 40, color: AppColors.secondColor.withOpacity(0.5),),
                        onTap: () {
                          controller.showImageSourceDialog(context);
                        },
                      ),
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
                                labelText: "companyName".tr,
                                hintText: "companyName".tr,
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
                          controller: controller.phoneController,
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
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: AppTheme().styles!.textStyle16WhiteColor,
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "address".tr,
                              hintText: "address".tr,
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
                          onTap: () => Get.back(),
                        ),
                      )
                    ],
                  ) : Center(
                    child: Container(
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      padding: const EdgeInsets.only(top: 32),
                      height: MediaQuery.of(context).size.height / 1.6,
                      decoration: BoxDecoration(
                          color: AppTheme().colors!.mainBackground,
                          borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                              child: Text(
                                "addClubCard".tr.toUpperCase(),
                                style: AppTheme().styles!.bold22,
                                textAlign: TextAlign.center,
                              )),
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
                                    onChanged: (v) {
                                      if (v.length >= 12) {
                                        controller.isValidName.value = true;
                                      } else {
                                        controller.isValidName.value = false;
                                      }
                                    },
                                    decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        hintText: "cardName".tr,
                                        hintStyle: controller.isValidName.value ? AppTheme().styles!.hintStyle16 : AppStyles.regularErrorText16,
                                        border: const OutlineInputBorder(borderSide: BorderSide.none)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.1,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    style:AppTheme().styles!.textStyle16WhiteColor,
                                    decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        hintText: "barcode".tr,
                                        hintStyle: AppTheme().styles!.hintStyle16,
                                        border: const OutlineInputBorder(borderSide: BorderSide.none)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 16, right: 16),
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: AppTheme().colors!.mainBackground,
                                      borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Icon(Icons.photo, color: AppColors.hintTextColor, size: 35,),
                                ),
                              ),
                            ],),
                          Container(
                              margin: const EdgeInsets.only(left: 24, right: 24, top: 16),
                              child: ButtonWidget(
                                height: 50,
                                title: "scanQrCode".tr.toUpperCase(),
                                isDisabledBtn: true,
                              )),
                          Container(
                              margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                              child: ButtonWidget(
                                height: 50,
                                title: "save".tr.toUpperCase(),
                                isDisabledBtn: true,
                                onTap: () {
                                },
                              ))
                        ],
                      ),
                      ),
                    ),

                  const SizedBox(height: 16),

                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
