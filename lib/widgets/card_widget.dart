
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Text(
                  model.date.toString(),
                  style: AppStyles.regularText,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Text(
                model.cardName.toString(),
                style: AppStyles.regularWhiteHeading18
            ),
            SizedBox(height: 0,)
          ],
        ),
      ),
    );
  }
}
