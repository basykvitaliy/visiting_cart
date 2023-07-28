import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';

import 'favorite_controller.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Favorite"),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: AppTheme().colors!.mainBackground,
        body: Container(),
    );
  }
}

