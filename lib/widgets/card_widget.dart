
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/helpers/utils.dart';
import 'package:visiting_card/model/my_card/card_model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.model,
  });

  final CardModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: convertHexToColor(model.backgroundColor.toString()),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  model.date.toString(),
                  style: AppStyles.regularText,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            SizedBox(
              width: 200,
              child: Image.memory(
                model.photo!,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 0,)
          ],
        ),
      ),
    );
  }
}
