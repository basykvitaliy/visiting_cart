

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:visiting_card/helpers/app_colors.dart';

class ScanController extends GetxController {
  static ScanController get to => Get.find();

  RxBool isPause = true.obs;
  RxBool isFlash = false.obs;
  RxBool isFlipCamera = false.obs;

  RxString barcodeMainValue = "".obs;

  void toggleIsFlash() => isFlash.toggle();

  void toggleIsPause() => isPause.toggle();

  Barcode? barcodeResult;
  late QRViewController controllerQr;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  RxString title = "".obs;
  RxInt price = 0.obs;
  String? article;
  ValueNotifier<dynamic> result = ValueNotifier(null);
  RxString serialNumberChip = "".obs;
  String resultBarcode = '';
  RxBool isLargeAnim = false.obs;
  

  Widget buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 250.0 : 350.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: AppColors.secondColor,
        borderRadius: 10,
        borderLength: 20,
        borderWidth: 10,
        cutOutHeight: 250,
        cutOutWidth: MediaQuery.of(context).size.width / 1.3,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController qController) {

    controllerQr = qController;
    controllerQr.resumeCamera();
    qController.scannedDataStream.listen((scanData) {
      barcodeResult = scanData;
      barcodeMainValue.value = barcodeResult!.code!;

    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

}
