import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visiting_card/routes/app_pages.dart';
import 'package:visiting_card/screens/home/home_screen.dart';
import 'package:visiting_card/screens/menu/menu_screen.dart';
import 'package:visiting_card/translation/Messages.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await checkPermissions();

  /// Permission for visible image network.
  final context = SecurityContext.defaultContext;
  context.allowLegacyUnsafeRenegotiation = true;

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
      home: MenuScreen(),
    );
  }
}
