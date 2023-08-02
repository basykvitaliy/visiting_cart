import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/screens/settings/settings_controller.dart';
import 'package:visiting_card/widgets/button_widget.dart';


class SettingsScreen extends GetView<SettingsController> {
  SettingsScreen({Key? key}) : super(key: key);
  @override
  final SettingsController controller = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("settings".tr, style: AppStyles.boldWhiteHeading,),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppTheme().colors!.secondColors,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  children: [
                    IconButton(icon: SvgPicture.asset("assets/svg/arrow_back.svg", width: 15, color: AppTheme().colors!.textColors,), onPressed: () => Get.back(),)
                  ],
                ),
                Text(
                  "selectATheme".tr.toUpperCase(),
                  style: AppTheme().styles!.bold22,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        controller.toggleTheme();
                        AppTheme().setTheme(isDark: false);
                        Get.forceAppUpdate();
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                                color: AppTheme().colors!.mainBackground,
                                borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 2, color: AppColors.errorColor)
                            ),
                            child: !controller.isDarkTheme.value
                                ? Icon(Icons.check, size: 15, color: AppTheme().colors!.checkBoxColor,)
                                : Container(),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        controller.toggleTheme();
                        AppTheme().setTheme(isDark: true);
                        Get.forceAppUpdate();
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                                color: AppTheme().colors!.mainBackground,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 2, color: AppColors.errorColor)
                            ),
                            child: controller.isDarkTheme.value ? Icon(Icons.check, size: 15,color: AppTheme().colors!.checkBoxColor,) : Container(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ButtonWidget(
                height: 50,
                title: "save".tr.toUpperCase(),
                isDisabledBtn: true,
                onTap: () => controller.saveAppTheme().whenComplete(() => Get.back()),
              ),
            ),
          ],
        ),

    );
  }
}

