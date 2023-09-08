import 'dart:io';
import 'package:edge_detection/edge_detection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:visiting_card/ad/ad_mob.dart';
import 'package:visiting_card/data/sql_db/SqlDbRepository.dart';
import 'package:visiting_card/helpers/constants.dart';
import 'package:visiting_card/helpers/utils.dart';
import 'package:visiting_card/model/logos/logos_model.dart';
import 'package:visiting_card/model/my_card/card_fb_model.dart';
import 'package:visiting_card/model/my_card/card_model.dart';
import 'package:visiting_card/services/firebase_services.dart';
import 'package:visiting_card/widgets/picker_photo_dialog.dart';

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

  Rx<File> image = File('').obs;
  RxBool isLoadImage = false.obs;
  RxBool isPhotoOrUrl = false.obs;
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
  void onInit() async {
    const imagePath = 'assets/images/bgcard.png';
    final byteData = await rootBundle.load(imagePath);

    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/bgcard.png';
    await File(tempPath).writeAsBytes(byteData.buffer.asUint8List());

    image.value = File(tempPath);
    _createInterstitialAd();
    super.onInit();
  }

  Future<List<LogosModel>> getLogos() async {
    return await FirebaseServices().getLogos();
  }

  Future<AuthStatus> saveNewPersonCard() async {
    var uuid = const Uuid();
    var card = CardModel();
    var cardFb = CardFBModel();
    card.id = uuid.v1();
    card.cardName = cardNameController.text;
    card.barcode = barcodeController.text;
    card.photo = isPhotoOrUrl.value ? imageBytes : await FirebaseServices().downloadAndSaveImage(logo.value);
    card.date = getDateTimeNow();
    card.backgroundColor = backgroundColor.value;

    cardFb.id = card.id;
    cardFb.cardName = card.cardName;
    cardFb.barcode = card.barcode;
    cardFb.date = card.date;
    cardFb.backgroundColor = card.backgroundColor;
  if(imageAvatarUrl != ""){
    await FirebaseServices().uploadImageToFirebaseStorage(imageAvatarUrl!).then((value) async {
      if (value.isNotEmpty) {
        cardFb.photo = value;
        await FirebaseServices().writeCardToFirebase(cardFb);
      }
    });
  }else{
    cardFb.photo = logo.value;
    await FirebaseServices().writeCardToFirebase(cardFb);
  }

    return await SqlDbRepository.instance.insertCard(card);
  }

  Future<void> getImageFromCamera() async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted = await Permission.camera.request() == PermissionStatus.granted;
    }
    if (!isCameraGranted) return;

    String imagePath = join((await getApplicationSupportDirectory()).path, "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");
    try {
      //Make sure to await the call to detectEdge.
      bool success = await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle: 'Scanning',
        // use custom localizations for android
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      isLoadImage.value = true;
      isPhotoOrUrl.value = true;
      imageBytes = Uint8List.fromList(File(imagePath).readAsBytesSync());
      print("success: $success");
    } catch (e) {
      print(e);
    }
    imageAvatarUrl = imagePath;
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid ? 'ca-app-pub-8171967781718919/2256605705' : 'ca-app-pub-3940256099942544/4411468910',
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
      onAdShowedFullScreenContent: (InterstitialAd ad) => print('ad onAdShowedFullScreenContent.'),
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
