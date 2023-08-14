import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visiting_card/ad/ad_mob.dart';
import 'package:visiting_card/data/sql_db/SqlDbRepository.dart';
import 'package:visiting_card/data/sql_db/SqlDbRepository.dart';
import 'package:visiting_card/helpers/constants.dart';
import 'package:visiting_card/helpers/utils.dart';
import 'package:visiting_card/model/logos/logos_model.dart';
import 'package:visiting_card/model/my_card/address_model.dart';
import 'package:visiting_card/model/my_card/card_model.dart';
import 'package:visiting_card/services/firebase_services.dart';
import 'package:visiting_card/widgets/picker_photo_dialog.dart';

class AddClubCardController extends GetxController with GetTickerProviderStateMixin {
  static AddClubCardController get to => Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  Rx<bool> isValidName = true.obs;
  Rx<bool> isValidPhone = true.obs;
  bool isName(String input) => input.isNotEmpty;
  bool isCardName(String input) => input.isNotEmpty;
  bool isBarcode(String input) => input.isNotEmpty;
  bool isPhone(String input) => RegExp(r'(^(?:[+38])?[0-9]{10,12}$)', caseSensitive: false).hasMatch(input);
  TextEditingController nameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString proffesional = ''.obs;

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
  AddressModel address = AddressModel();

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  static final AdRequest request = AdRequest(
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
    addAddress();
    var card = CardModel();
    card.type = isSetType.value ? 1 : 0;
    card.nameUser = nameController.text;
    card.companyName = companyNameController.text;
    card.cardName = cardNameController.text;
    card.barcode = barcodeController.text;
    card.profession = professionController.text;
    card.phone = phoneController.text;
    card.email = emailController.text;
    card.logo = "";
    card.photo = imageBytes;
    card.address = address;
    card.date = getDateTimeNow();
    card.isFavorite = 0;
    card.backgroundColor = Colors.primaries[Random().nextInt(Colors.primaries.length)].shade200.withOpacity(0.5).value.toRadixString(16);

    return await SqlDbRepository.instance.insertCard(card);
  }

  Future<void> addAddress()async{
    address.office = '';
    address.house = '';
    address.street = '';
    address.city = '';
    addressController.text =
        "${address.office.toString()}, "
        "${address.house.toString()}, "
        "${address.city.toString()}, "
        "${address.street.toString()}";
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
