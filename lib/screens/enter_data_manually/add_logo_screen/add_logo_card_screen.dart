import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:visiting_card/screens/enter_data_manually/enter_data_controller.dart';

import '../../../helpers/app_colors.dart';

class AddLogoCardScreen extends GetView<EnterDataController> {
  AddLogoCardScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SvgPicture.asset(
                  "assets/svg/arrow_back.svg",
                  color: AppTheme().isLightTheme ? AppColors.mainTextColor : AppColors.whiteColor,
                )),
          ),
          elevation: 0,
          backgroundColor: AppTheme().colors!.mainBackground,
        ),
        backgroundColor: AppTheme().colors!.mainBackground,
        body: GridView.builder(
          itemCount: 1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 3 : 4),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){

              },
              child: Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(8),

              ),
            );
          },
        ),
        );
  }
}
