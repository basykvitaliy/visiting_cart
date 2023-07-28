import 'package:get/get.dart';
import 'package:visiting_card/screens/favorite/favorite_controller.dart';


class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteController());
  }
}
