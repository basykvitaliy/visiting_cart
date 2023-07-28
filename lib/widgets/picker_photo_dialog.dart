import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visiting_card/helpers/app_colors.dart';

class PickPhotoDialog {
  static Future<ImageSource?> showPickPhotoDialog({
    String title = 'Error',
    String? message,
    String? confirmButtonText,
    VoidCallback? confirmCallback,
    Color? titleFillColor,
    VoidCallback? cancelCallback,
    String cancelButtonText = "cancel",
    Widget? child,
    double? width,
    double? height,
  }) async {
    if (Get.isBottomSheetOpen == null) Get.back();

    return Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: 'BarrierLabel',
      pageBuilder: (_, __, ___) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: AppColors.mainColor,
                  height: height,
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.close)
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => Get.back(result: ImageSource.gallery),
                          child: Container(
                            width: width,
                            height: Get.height,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.whiteColor),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.photo,
                                    size: 60,
                                    color: AppColors.mainColor.withOpacity(0.3),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "myPhotos".tr,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => Get.back(result: ImageSource.camera),
                          child: Container(
                            width: width,
                            height: Get.height,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.whiteColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 60,
                                  color: AppColors.mainColor.withOpacity(0.3),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "camera".tr,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
