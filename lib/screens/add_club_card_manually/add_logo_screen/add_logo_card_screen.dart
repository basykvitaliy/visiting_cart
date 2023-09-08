import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/session.dart';
import 'package:visiting_card/helpers/utils.dart';
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
          automaticallyImplyLeading: true,
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
                      controller.backgroundColor.value = logosList[index].backgroundColor.toString();
                      controller.logo.value = logosList[index].image.toString();
                      controller.isLoadImage.value = true;
                      controller.isPhotoOrUrl.value = false;
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: convertHexToColor(logosList[index].backgroundColor.toString()),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                              child: Image.network(logosList[index].image.toString(), )),

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
