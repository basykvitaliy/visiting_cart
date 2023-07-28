
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visiting_card/widgets/picker_photo_dialog.dart';

class ProfileController extends GetxController{
  static ProfileController get to => Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  Rx<bool> isValidEmail = true.obs;
  Rx<bool> isValidName = true.obs;
  Rx<bool> isValidPhone = true.obs;
  bool isName(String input) => input.isNotEmpty;
  bool isPhone(String input) => RegExp(r'(^(?:[+38])?[0-9]{10,12}$)', caseSensitive: false).hasMatch(input);
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
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
  RxBool isLargeAnimation = false.obs;

  DateTime _date = DateTime.now();
  final DateFormat _dateFormat = DateFormat("MMM dd, yyyy");

  @override
  void onInit()async {
    const imagePath = 'assets/images/login_bg.png';
    final byteData = await rootBundle.load(imagePath);

    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/login_bg.png';
    await File(tempPath).writeAsBytes(byteData.buffer.asUint8List());

    image.value = File(tempPath);
    super.onInit();
  }

  /// Show calendar for select date birth.
  void handleDatePicker(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (date != null && date != _date) {
      _date = date;
    }
    birthDayController.text = _dateFormat.format(date!);
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
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
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