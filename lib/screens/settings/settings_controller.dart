import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visiting_card/helpers/constants.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  RxBool isDarkTheme = false.obs;
  void toggleTheme() => isDarkTheme.toggle();

  Future<void> saveAppTheme()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(Keys.isDarkTheme, isDarkTheme.value);
  }

  @override
  void onInit() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var theme = sharedPreferences.getBool(Keys.isDarkTheme);
    if(theme == null){
      isDarkTheme.value = false;
    }else{
      isDarkTheme.value = theme;
    }
    super.onInit();
  }
}
