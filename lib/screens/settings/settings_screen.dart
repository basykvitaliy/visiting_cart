import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/screens/settings/settings_controller.dart';


class SettingsScreen extends GetView<SettingsController> {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: AppColors.bgLayout,
        body: Container(),

    );
  }
}

