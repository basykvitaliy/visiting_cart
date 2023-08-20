
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
import 'package:synchronized/synchronized.dart';
import 'package:uuid/uuid.dart';
import 'package:visiting_card/ad/ad_mob.dart';
import 'package:visiting_card/data/sql_db/SqlDbRepository.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/helpers/constants.dart';
import 'package:visiting_card/helpers/session.dart';
import 'package:visiting_card/helpers/utils.dart';
import 'package:visiting_card/model/my_card/card_fb_model.dart';
import 'package:visiting_card/model/my_card/card_model.dart';
import 'package:visiting_card/model/user/user_model.dart';
import 'package:visiting_card/screens/base_controller.dart';
import 'package:visiting_card/screens/home/home_controller.dart';
import 'package:visiting_card/services/firebase_services.dart';
import 'package:visiting_card/widgets/picker_photo_dialog.dart';

class ProfileController extends BaseController{
  static ProfileController get to => Get.find();

  BannerAd? bannerAd;
  late final GoogleSignInAccount? googleUser;
  final _lock = Lock();

  @override
  void onInit()async {
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
    await getUser();
    super.onInit();
  }

  Future<void> saveUser(UserModel userModel)async{
    await SqlDbRepository.instance.insertUser(userModel);
  }

  Future<void> deleteUser(UserModel userModel)async{
    await SqlDbRepository.instance.deleteUser(userModel);
    await SqlDbRepository.instance.deleteAllCards();
  }

  Future<bool> signInWithGoogle() async {
    try {
      await FirebaseServices().signInWithGoogle().then((value) async {
        googleUser = value;
        isBuyer.value = value!.email.isNotEmpty ? true : false;
      });

      if (isBuyer.isFalse) {
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
          var u = UserModel(
              name: googleUser?.displayName,
              photo: googleUser?.photoUrl,
              email: googleUser?.email
          );
          await saveUser(u);
          if (v.user != null) {
            User? user = FirebaseAuth.instance.currentUser;
            var token = await user!.getIdToken();
            Session.authToken = token;
            await _lock.synchronized(() async {
              await FirebaseServices().getCards().then((value) async{
                value.forEach((element)async {
                  await saveNewPersonCard(element);
                });
              });
              await HomeController.to.getUser();
              await HomeController.to.getCardList();
              Get.back();
            });

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
    return isBuyer.value;
  }

  Future<AuthStatus> saveNewPersonCard(CardFBModel model)async{
    var uuid = const Uuid();
    var card = CardModel();
    card.id = uuid.v1();
    card.cardName = model.cardName;
    card.barcode = model.barcode;
    card.photo = await FirebaseServices().downloadAndSaveImage(model.photo.toString());
    card.date = getDateTimeNow();
    card.backgroundColor = model.backgroundColor;
    return await SqlDbRepository.instance.insertCard(card);
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

}