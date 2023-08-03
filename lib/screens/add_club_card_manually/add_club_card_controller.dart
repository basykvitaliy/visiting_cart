import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visiting_card/data/sql_db/SqlDbRepository.dart';
import 'package:visiting_card/data/sql_db/SqlDbRepository.dart';
import 'package:visiting_card/helpers/constants.dart';
import 'package:visiting_card/helpers/utils.dart';
import 'package:visiting_card/model/logos/logos_model.dart';
import 'package:visiting_card/model/my_card/address_model.dart';
import 'package:visiting_card/model/my_card/card_model.dart';
import 'package:visiting_card/services/firebase_services.dart';
import 'package:visiting_card/widgets/picker_photo_dialog.dart';

class AddClubCardController extends GetxController with GetTickerProviderStateMixin {
  static AddClubCardController get to => Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  Rx<bool> isValidName = true.obs;
  Rx<bool> isValidPhone = true.obs;
  bool isName(String input) => input.isNotEmpty;
  bool isCardName(String input) => input.isNotEmpty;
  bool isBarcode(String input) => input.isNotEmpty;
  bool isPhone(String input) => RegExp(r'(^(?:[+38])?[0-9]{10,12}$)', caseSensitive: false).hasMatch(input);
  TextEditingController nameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString proffesional = ''.obs;

  final ImagePicker _picker = ImagePicker();
  Rx<File> image = File('').obs;
  CroppedFile? _croppedFile;
  RxBool isLoadImage = false.obs;
  RxBool isShowEditButton = true.obs;
  String? imageAvatarUrl = "";
  RxString imageClubPath = ''.obs;
  Uint8List? imageBytes;
  RxInt idUser = 0.obs;
  RxBool isSetType = false.obs;
  AddressModel address = AddressModel();

  @override
  void onInit()async {
    const imagePath = 'assets/images/bgcard.png';
    final byteData = await rootBundle.load(imagePath);

    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/bgcard.png';
    await File(tempPath).writeAsBytes(byteData.buffer.asUint8List());

    image.value = File(tempPath);
    super.onInit();
  }

  Future<List<LogosModel>> getLogos()async{
   return await FirebaseServices().getLogos();
  }

  Future<AuthStatus> saveNewPersonCard()async{
    addAddress();
    var card = CardModel();
    card.type = isSetType.value ? 1 : 0;
    card.nameUser = nameController.text;
    card.companyName = companyNameController.text;
    card.cardName = cardNameController.text;
    card.barcode = barcodeController.text;
    card.profession = professionController.text;
    card.phone = phoneController.text;
    card.email = emailController.text;
    card.logo = "";
    card.photo = imageBytes;
    card.address = address;
    card.date = getDateTimeNow();
    card.isFavorite = 0;
    card.backgroundColor = Colors.primaries[Random().nextInt(Colors.primaries.length)].shade200.withOpacity(0.5).value.toRadixString(16);

    return await SqlDbRepository.instance.insertCard(card);
  }

  Future<void> addAddress()async{
    address.office = '';
    address.house = '';
    address.street = '';
    address.city = '';
    addressController.text =
        "${address.office.toString()}, "
        "${address.house.toString()}, "
        "${address.city.toString()}, "
        "${address.street.toString()}";
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source);
      if (image == null) return;
      isLoadImage.value = true;
      final imageTemporary = File(image.path);
      this.image.value = imageTemporary;
      imageAvatarUrl = imageTemporary.path;
      imageBytes = await image.readAsBytes();
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void getImage()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.containsKey("image")){
      imageClubPath.value = sharedPreferences.getString("image")!;
    }else{
      imageClubPath.value = "";
    }
  }

  Future<ImageSource?> showImageSourceDialog(BuildContext context) async {
    final source = await PickPhotoDialog.showPickPhotoDialog(
        title: "uploadPhotos".tr,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.5);
    if (source == ImageSource.camera) {
      await pickImage(source!);
    } else {
      await pickImage(source!);
    }
    return null;
  }

  Future<void> cropSImage(File imageFile) async {
    _croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio3x2
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    isLoadImage.value = true;
    image.value = File(_croppedFile!.path);
  }

}
