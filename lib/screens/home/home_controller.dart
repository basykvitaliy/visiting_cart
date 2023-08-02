import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visiting_card/data/sql_db/SqlDbRepository.dart';
import 'package:visiting_card/model/my_card/card_model.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  static HomeController get to => Get.find();
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController(text: "Search");

  RxBool isFavorite = false.obs;
  void toggleFavorite() => isFavorite.toggle();
  RxList<CardModel> cardList = RxList<CardModel>();


  Future<List<dynamic>> search(String query)async{
    return [];
  }


  Future<List<CardModel>> getCardList()async{
    cardList.value = await SqlDbRepository.instance.getUserCards();
    return cardList;
  }

  Future<bool> deleteCard(String id)async{
    return await SqlDbRepository.instance.deleteCard(id);
  }

}
