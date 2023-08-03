import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:visiting_card/model/logos/logos_model.dart';
import 'package:visiting_card/screens/add_club_card_manually/add_club_card_controller.dart';

import '../../../helpers/app_colors.dart';

class AddLogoCardScreen extends GetView<AddClubCardController> {
  AddLogoCardScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "addClubCard".tr,
            style: AppStyles.boldWhiteHeading,
          ),
          centerTitle: true,
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
          backgroundColor: AppTheme().colors!.secondColors,
        ),
        backgroundColor: AppTheme().colors!.mainBackground,
        body: FutureBuilder(
          future: controller.getLogos(),
            builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else{
            var logosList = snapshot.data as List<LogosModel>;
             return ListView.builder(
               itemCount: logosList.length,
                 itemBuilder: (ctx, index){
                  return GestureDetector(
                    onTap: (){
                      controller.cardNameController.text = logosList[index].title.toString();
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.secondColor)
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(logosList[index].title.toString()),
                        ],
                      ),
                    ),
                  );
             });
          }
        }),
        );
  }
}
