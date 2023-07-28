import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/widgets/button_widget.dart';

import 'favorite_controller.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme().colors!.secondColors,

      ),
      backgroundColor: AppTheme().colors!.mainBackground,
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 32, top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularProfileAvatar(
              '',
              borderColor: AppColors.whiteColor,
              borderWidth: 1,
              elevation: 1,
              radius: 80,
              backgroundColor: AppColors.hintTextColor,
              child: const Icon(Icons.person),
            ),
            Text("Name", style: AppTheme().styles!.bold20),
            QrImage(
              foregroundColor: AppTheme().colors!.secondColors,
              data: 're34jefg9werng0erg',
              version: QrVersions.auto,
              size: 320,
              gapless: false,
            ),
          ],
        ),
      ),
    );
  }
}
