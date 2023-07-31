import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:visiting_card/helpers/app_colors.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.isFavorite,
    required this.favorite,
  });

  final bool isFavorite;
  final Callback favorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade200.withOpacity(0.5),
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
                Container(
                  width: 100,
                  height: 20,
                  decoration: const BoxDecoration(
                      color: AppColors.secondColor
                  ),
                  child: Text("Business", style: AppStyles.regularWhiteText14, textAlign: TextAlign.center,),
                ),
                Text("22.13.2033", style: AppStyles.regularBodyDarkText12, textAlign: TextAlign.center,)
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
                      child: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name Surname", style: AppStyles.regularDarkTextBold16, textAlign: TextAlign.center,),
                        SizedBox(height: 8,),
                        Text("Profession", style: AppStyles.regularDarkText16, textAlign: TextAlign.center,),
                        SizedBox(height: 8,),
                        Text("+38065774567", style: AppStyles.regularDarkTextBold16, textAlign: TextAlign.center,),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: favorite,
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: !isFavorite
                          ? Icon(Icons.favorite_border, size: 30, color: AppColors.whiteColor,)
                          : Icon(Icons.favorite, size: 30, color: AppColors.whiteColor,)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}