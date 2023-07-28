import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/routes/routes.dart';

import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppTheme().colors!.secondColors,
          actions: [
            GestureDetector(
              onTap: () => Get.toNamed(Routes.settingsScreen),
              child: Container(
                margin: EdgeInsets.only(right: 8),
                  child: Icon(Icons.settings)),
            )
          ],
        ),
        backgroundColor: AppTheme().colors!.mainBackground,
        body: Container(),

    );
  }
}

