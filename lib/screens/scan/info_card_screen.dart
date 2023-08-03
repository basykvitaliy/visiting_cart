import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/model/my_card/card_model.dart';
import 'package:visiting_card/screens/scan/scan_controller.dart';

class InfoCardScreen extends GetView<ScanController> {
  const InfoCardScreen( {
    Key? key,
    required this.cardModel
  }) : super(key: key);
  final CardModel cardModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(cardModel.cardName.toString()),
          centerTitle: true,
          backgroundColor: Color(int.parse(cardModel.backgroundColor!, radix: 16)),
          automaticallyImplyLeading: true,
        ),
        backgroundColor: AppColors.mainColor,
        body:  Center(
          child: SizedBox(
            height: 150,
            child: SfBarcodeGenerator(textStyle: AppStyles.regularHeading18,
              textSpacing: 5,
              value: cardModel.barcode.toString(),
              showValue: true,
            ),
          ),
        ));
  }
}
