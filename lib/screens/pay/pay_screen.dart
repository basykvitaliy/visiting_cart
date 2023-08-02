import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:visiting_card/helpers/app_colors.dart';
import 'package:visiting_card/screens/pay/pay_controller.dart';

class PayScreen extends GetView<PayController> {
  PayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pay".tr, style: AppStyles.boldWhiteHeading,),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme().colors!.secondColors,
      ),
      backgroundColor: AppTheme().colors!.mainBackground,
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 32, top: 16),
      ),
    );
  }
}
