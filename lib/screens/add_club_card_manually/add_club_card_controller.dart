import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:visiting_card/ad/ad_mob.dart';
import 'package:visiting_card/data/sql_db/SqlDbRepository.dart';
import 'package:visiting_card/helpers/constants.dart';
import 'package:visiting_card/helpers/utils.dart';
import 'package:visiting_card/model/logos/logos_model.dart';
import 'package:visiting_card/model/my_card/card_fb_model.dart';
import 'package:visiting_card/model/my_card/card_model.dart';
import 'package:visiting_card/services/firebase_services.dart';

class AddClubCardController extends GetxController with GetTickerProviderStateMixin {
  static AddClubCardController get to => Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  Rx<bool> isValidName = true.obs;
  Rx<bool> isValidPhone = true.obs;
  bool isCardName(String input) => input.isNotEmpty;
  bool isBarcode(String input) => input.isNotEmpty;
  TextEditingController cardNameController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  RxString backgroundColor = ''.obs;
  RxString logo = ''.obs;

  final ImagePicker _picker = ImagePicker();
  Rx<File> image = File('').obs;
  CroppedFile? _croppedFile;
  RxBool isLoadImage = false.obs;
  RxBool isShowEditButton = true.obs;
  String? imageAvatarUrl = "";
  RxString imageClubPath = ''.obs;
  Uint8List? imageBytes;
  RxInt idUser = 0.obs;
  RxBool isSetType = false.obs;

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  @override
  void onInit()async {
    const imagePath = 'assets/images/bgcard.png';
    final byteData = await rootBundle.load(imagePath);

    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/bgcard.png';
    await File(tempPath).writeAsBytes(byteData.buffer.asUint8List());

    image.value = File(tempPath);
    _createInterstitialAd();
    super.onInit();
  }

  Future<List<LogosModel>> getLogos()async{
   return await FirebaseServices().getLogos();
  }

  Future<AuthStatus> saveNewPersonCard()async{
    var uuid = const Uuid();
    var card = CardModel();
    var cardFb = CardFBModel();
    card.id = uuid.v1();
    card.cardName = cardNameController.text;
    card.barcode = barcodeController.text;
    card.photo = await FirebaseServices().downloadAndSaveImage(logo.value);
    card.date = getDateTimeNow();
    card.backgroundColor = backgroundColor.value;

    cardFb.id = card.id;
    cardFb.cardName = card.cardName;
    cardFb.barcode = card.barcode;
    cardFb.photo = logo.value;
    cardFb.date = card.date;
    cardFb.backgroundColor = card.backgroundColor;

    await FirebaseServices().writeCardToFirebase(cardFb);
    return await SqlDbRepository.instance.insertCard(card);
  }


  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-3940256099942544/4411468910',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
