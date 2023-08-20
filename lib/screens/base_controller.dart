import 'package:get/get.dart';
import 'package:visiting_card/data/sql_db/SqlDbRepository.dart';
import 'package:visiting_card/model/user/user_model.dart';

class BaseController extends GetxController{

  RxBool isBuyer = false.obs;
  Rx<UserModel> user = UserModel().obs;

  Future<bool> getUser()async{
    user.value = (await SqlDbRepository.instance.getUser())!;
    if(user.value.name!.isNotEmpty) isBuyer.value = true;
    return isBuyer.value;
  }
}