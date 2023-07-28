import 'package:get/get.dart';
import 'package:visiting_card/screens/scan/scan_controller.dart';

class ScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ScanController());
  }
}
