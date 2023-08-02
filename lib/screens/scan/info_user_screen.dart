
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/model/my_card/card_model.dart';
import 'package:visiting_card/screens/scan/scan_controller.dart';
import 'package:visiting_card/widgets/button_loading_widget.dart';
import 'package:visiting_card/widgets/button_widget.dart';

class InfoUserScreen extends GetView<ScanController> {
  const InfoUserScreen( {
    Key? key,
    required this.cardModel
  }) : super(key: key);
  final CardModel cardModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme().colors!.secondColors,
          automaticallyImplyLeading: true,
        ),
        backgroundColor: AppColors.mainColor,
        body: Column(
          children: [
            Text(cardModel.nameUser != "" ? cardModel.nameUser.toString() : cardModel.cardName.toString())
          ],
        ));
  }
}
