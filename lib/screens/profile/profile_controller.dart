
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visiting_card/ad/ad_mob.dart';
import 'package:visiting_card/data/sql_db/SqlDbRepository.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/helpers/constants.dart';
import 'package:visiting_card/helpers/session.dart';
import 'package:visiting_card/model/user/user_model.dart';
import 'package:visiting_card/services/firebase_services.dart';
import 'package:visiting_card/widgets/picker_photo_dialog.dart';

class ProfileController extends GetxController{
  static ProfileController get to => Get.find();

  BannerAd? bannerAd;
  late final GoogleSignInAccount? googleUser;
  bool? isBuyer;

  @override
  void onInit() {
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
    super.onInit();
  }

  Future<void> signInWithGoogle() async {
    try {
      await FirebaseServices().signInWithGoogle().then((value) async {
        googleUser = value;
        //isBuyer = await FirebaseServices().verifyEmailByEmail(value!.email);
      });

      if (isBuyer != true) {

        Get.showSnackbar(GetSnackBar(
          titleText: Text("thereIsNoSuchUser".tr, style: AppTheme().styles!.hintStyle16,),
          messageText: Text("youNeedToRegister".tr, style: AppTheme().styles!.hintStyle14,),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(milliseconds: 1500),
          backgroundColor: AppColors.mainColor,
          borderRadius: LayoutConstants.snackBarRadius,
        ));
      } else {
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential).then((v) async {

          if (v.user != null) {
            User? user = FirebaseAuth.instance.currentUser;
            var token = await user!.getIdToken();
            Session.authToken = token;
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          print("The provider has already been linked to the user.");
          break;
        case "invalid-credential":
          print("The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          print("The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.");
          break;
      // See the API reference for the full list of error codes.
        default:
          print("Unknown error.");
      }
    }
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

}