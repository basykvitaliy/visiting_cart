import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
const String testDevice = 'YOUR_DEVICE_ID';
const int maxFailedLoadAttempts = 3;
class AdHelper {

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );


  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      //return 'ca-app-pub-3940256099942544/6300978111';
      return 'ca-app-pub-8171967781718919/3545868152';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      //return "ca-app-pub-3940256099942544/1033173712";
      return "ca-app-pub-8171967781718919/9617705497";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

}