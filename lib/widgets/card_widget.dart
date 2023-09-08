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
      color: model.backgroundColor != "" ? convertHexToColor(model.backgroundColor.toString()) : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      elevation: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: model.photo != null
            ? Image.memory(
                model.photo!,
                scale: 2,
              )
            : const SizedBox(
                height: 0,
              ),
      ),
    );
  }
}
