import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuController extends GetxController with GetTickerProviderStateMixin {
  static MenuController get to => Get.find();
  RxInt selectedIndex = 0.obs;
}
