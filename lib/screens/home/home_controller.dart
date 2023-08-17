import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:visiting_card/ad/ad_mob.dart';
import 'package:visiting_card/data/sql_db/SqlDbRepository.dart';
import 'package:visiting_card/model/my_card/card_model.dart';
import 'package:visiting_card/screens/base_controller.dart';

class HomeController extends BaseController {
  static HomeController get to => Get.find();
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController(text: "Search");

  RxBool isFavorite = false.obs;
  void toggleFavorite() => isFavorite.toggle();
  RxList<CardModel> cardList = RxList<CardModel>();

  BannerAd? bannerAd;

  Future<List<CardModel>> getCardList()async{
    cardList.value = await SqlDbRepository.instance.getUserCards();
    return cardList;
  }

  Future<bool> deleteCard(String id)async{
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
    await getUser();
    super.onInit();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

}
