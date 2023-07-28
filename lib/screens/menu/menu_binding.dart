import 'package:get/get.dart';
import 'package:visiting_card/screens/home/home_controller.dart';
import 'package:visiting_card/screens/menu/menu_main_controller.dart';


class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MenuMainController());
  }
}
