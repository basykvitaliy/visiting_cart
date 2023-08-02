import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:themed/themed.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/model/my_card/card_model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.model,
    required this.favorite,
  });

  final CardModel model;
  final Callback favorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Color(int.parse(model.backgroundColor!, radix: 16)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      elevation: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 20,
                      decoration: BoxDecoration(color: Color(int.parse(model.backgroundColor!, radix: 16)).withOpacity(1)),
                    ),
                    Text(
                      model.type == 0 ? "Personal" : "Business",
                      style: AppStyles.regularWhiteText12,
                    )
                  ],
                ),
                Text(
                  model.date.toString(),
                  style: AppStyles.regularBodyDarkText10,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.whiteColor),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: model.photo != null
                            ? Image.memory(model.photo!, fit: BoxFit.cover)
                            : Icon(
                                Icons.photo,
                                size: 55,
                                color: Color(int.parse(model.backgroundColor!, radix: 16)),
                              ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      height: 100,
                      child: model.type == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  model.nameUser.toString(),
                                  style: AppStyles.regularHeading18),
                                Text(
                                  model.profession.toString(),
                                  style: AppStyles.regularDarkText16,
                                ),
                                Text(
                                  model.phone != null ? model.phone.toString() : model.barcode.toString(),
                                  style: AppStyles.regularDarkTextBold16,
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  model.cardName.toString(),
                                  style: AppStyles.regularHeading18
                                ),
                                SizedBox(
                                  width: 115,
                                  height: 40,
                                  child: SfBarcodeGenerator(
                                    value: model.barcode.toString(),
                                    showValue: true,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: favorite,
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: model.isFavorite == 0
                          ? Icon(
                              Icons.favorite_border,
                              size: 30,
                            color: Color(int.parse(model.backgroundColor!, radix: 16)).withOpacity(1)
                            )
                          : Icon(
                              Icons.favorite,
                              size: 30,
                            color: Color(int.parse(model.backgroundColor!, radix: 16)).withOpacity(1)
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
