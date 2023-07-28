import 'package:get/get.dart';
import 'package:visiting_card/screens/home/home_controller.dart';
import 'package:visiting_card/screens/settings/settings_controller.dart';


class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
  }
}
