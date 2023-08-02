import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ImageUtils {
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    final data = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    final fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  static Future<ui.Image> getImageFromAsset(String path, {required int width}) async {
    final data = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    final fi = await codec.getNextFrame();
    return fi.image;
  }

  static Future<ByteData> load(Uri uri) async {
    final HttpClient httpClient = HttpClient();
    final HttpClientRequest request = await httpClient.getUrl(uri);
    final HttpClientResponse response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('Unable to load asset: $uri'),
        IntProperty('HTTP status code', response.statusCode),
      ]);
    }
    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    return bytes.buffer.asByteData();
  }

  static Future<ui.Image> getImageFromUrl(String url, {required int width}) async {
    final avatarImage = Image.network(url);
    final data = await load(Uri.parse(url));

    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    final fi = await codec.getNextFrame();
    return fi.image;
  }
}

class GeneralUtils {
  static bool isSmallScreen() {
    return Get.height < 640;
  }
}

String getStreamSize(double bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  final i = (math.log(bytes) / math.log(1024)).floor();
  return '${(bytes / math.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

Future<int> getFileSize(String filepath) async {
  final file = File(filepath);
  final int bytes = await file.length();
  return bytes;
}

Future<String> getFileSizeFormat(String filepath, int decimals) async {
  final file = File(filepath);
  final int bytes = await file.length();
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  final i = (math.log(bytes) / math.log(1024)).floor();
  return '${(bytes / math.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

String? humanizeDuration({required int seconds}) {
  if (seconds == null) return null;
  int remainder = seconds;
  final String hours = (remainder ~/ 3600).toString().padLeft(2, '0');
  remainder = seconds % 3600;
  final String minutes = (remainder ~/ 60).toString().padLeft(2, '0');
  remainder = remainder % 60;
  final String secs = remainder.toString().padLeft(2, '0');
  return '$hours:$minutes:$secs';
}

TimeAndUnit timeAndUnitFromSeconds(int value) {

  final timeAndUnit = TimeAndUnit();
  final elapsedTime = DateTime.now().toUtc().difference(dateTimeFromSeconds(value, isUtc: true));
  if (elapsedTime.inSeconds < 60.seconds.inSeconds) {
    timeAndUnit.time = elapsedTime.inSeconds;
    timeAndUnit.unit = 'sec';
  } else if (elapsedTime.inMinutes < 59.minutes.inMinutes) {
    timeAndUnit.time = elapsedTime.inMinutes;
    timeAndUnit.unit = 'min';
  } else {
    timeAndUnit.time = elapsedTime.inHours;
    timeAndUnit.unit = elapsedTime.inHours > 1 ? 'hours' : 'hour';
  }
  return timeAndUnit;
}

int dateTimeToSeconds(DateTime dateTime) => dateTime.millisecondsSinceEpoch ~/ 1000;

int millisecondsToSeconds(int ms) => ms ~/ 1000;

DateTime dateTimeFromSeconds(int seconds, {bool isUtc = false}) {
  return DateTime.fromMillisecondsSinceEpoch(seconds * 1000, isUtc: isUtc);
}

String getDateTimeNow(){
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd.MM.yyyy HH:mm').format(now);
  return formattedDate;
}

String? getFilenameFromUrl(String url) {
  final regexp = RegExp(r'[^/\\&\?]+\.\w{3,4}(?=([\?&].*$|$))');
  return regexp.firstMatch(url)?.group(0);
}

class TimeAndUnit {
  int? time;
  String? unit;

  TimeAndUnit({
    this.time,
    this.unit,
  });
}

extension BoolParsing on String {
  bool parseBool() {
    return toLowerCase() == 'true';
  }
}
