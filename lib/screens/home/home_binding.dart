import 'package:get/get.dart';
import 'package:visiting_card/screens/home/home_controller.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
