import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visiting_card/routes/app_pages.dart';
import 'package:visiting_card/screens/home/home_screen.dart';
import 'package:visiting_card/screens/menu/menu_screen.dart';
import 'package:visiting_card/translation/Messages.dart';

import 'helpers/app_colors.dart';
import 'helpers/constants.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await checkPermissions();

  /// Permission for visible image network.
  final context = SecurityContext.defaultContext;
  context.allowLegacyUnsafeRenegotiation = true;

  MobileAds.instance.initialize();

  /// Set theme
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var theme = sharedPreferences.getBool(Keys.isDarkTheme);
  if(theme == null){
    AppTheme().setTheme(isDark: false);
  }else{
    AppTheme().setTheme(isDark: theme);
  }

  runApp(const MyApp());
}

Future<void> checkPermissions() async {
  await [
    Permission.camera,
    Permission.storage,
  ].request();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Visiting Card',
      getPages: AppPages.pages,
      translations: Messages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
