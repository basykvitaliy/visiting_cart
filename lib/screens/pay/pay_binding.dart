import 'package:get/get.dart';
import 'package:visiting_card/screens/pay/pay_controller.dart';


class PayBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PayController());
  }
}
