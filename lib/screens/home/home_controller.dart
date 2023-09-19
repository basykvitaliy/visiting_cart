import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:visiting_card/ad/ad_mob.dart';
import 'package:visiting_card/data/sql_db/SqlDbRepository.dart';
import 'package:visiting_card/model/my_card/card_fb_model.dart';
import 'package:visiting_card/model/my_card/card_model.dart';
import 'package:visiting_card/screens/base_controller.dart';
import 'package:visiting_card/services/firebase_services.dart';

class HomeController extends BaseController {
  static HomeController get to => Get.find();
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController(text: "Search");

  RxBool isFavorite = false.obs;
  void toggleFavorite() => isFavorite.toggle();
  RxList<CardModel> cardList = RxList<CardModel>();
  RxList<CardFBModel> cardFBList = RxList<CardFBModel>();

  BannerAd? bannerAd;

  Future<List<CardModel>> getCardList()async{
    cardList.value = await SqlDbRepository.instance.getUserCards();
    if(cardList.isEmpty){
      cardFBList.value = await FirebaseServices().getCards();
      cardFBList.forEach((element) async{
        cardList.add(CardModel(
          id: element.id,
          cardName: element.cardName,
          barcode: element.barcode,
          backgroundColor: element.backgroundColor,
          photo: await FirebaseServices().downloadAndSaveImage(element.photo.toString()),
          date: element.date
        ));
      });

    }
    return cardList;
  }

  Future<bool> deleteCard(String id)async{
    await FirebaseServices().removeCard(id);
    return await SqlDbRepository.instance.deleteCard(id);
  }

  @override
  void onInit() async{
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
    await getCardList();
    //await getUser();
    super.onInit();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

}
