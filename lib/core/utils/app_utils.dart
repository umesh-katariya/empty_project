import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app_theme/app_colors.dart';
import '../widgets/image_view.dart';
import '../widgets/text_view.dart';
import '../widgets/theme_button.dart';
import 'app_assets.dart';
import 'storage_utils.dart';

class AppUtility {
  static showProgressDialog() async {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
      await Future.delayed(const Duration(milliseconds: 500));
    }
    Get.dialog(
      WillPopScope(
        onWillPop: () async => kDebugMode,
        child: AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: progressIndicator(),
        ),
      ),
    );
  }

  static Widget progressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),
    );
  }

  ///Method to show snack bar.
  static Future<SnackbarController> showSnackBar(
      {String? message, int? milliseconds, bool isSuccess = false}) async {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
      await Future.delayed(const Duration(milliseconds: 500));
    }
    return Get.showSnackbar(
      GetSnackBar(
        message: (message ?? '').isNotEmpty ? message : "error",
        duration: Duration(milliseconds: milliseconds ?? 3000),
        backgroundColor: AppColors.secondaryColor,
        margin: const EdgeInsets.all(5),
        borderRadius: 5,
        animationDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  ///Dialog for pick image from photos or camera.
  // static Future<File?> pickImage({int? type}) async {
  //   {
  //     dynamic result;
  //     if (type == null) {
  //       result = await showCupertinoModalPopup<String?>(
  //         context: Get.context!,
  //         builder: (BuildContext context) => CupertinoTheme(
  //           data: const CupertinoThemeData(
  //               primaryColor: AppColors.lushPinkColor,
  //               textTheme: CupertinoTextThemeData(
  //                   pickerTextStyle: TextStyle(color: AppColors.lushPinkColor))),
  //           child: CupertinoActionSheet(
  //             cancelButton: CupertinoActionSheetAction(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text('Cancel'),
  //             ),
  //             actions: <CupertinoActionSheetAction>[
  //               CupertinoActionSheetAction(
  //                 onPressed: () {
  //                   Navigator.pop(context, 1);
  //                 },
  //                 child: const Text('Camera'),
  //               ),
  //               CupertinoActionSheetAction(
  //                 onPressed: () {
  //                   Navigator.pop(context, 2);
  //                 },
  //                 child: const Text('Photos'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     } else {
  //       result = type;
  //     }
  //     File? selectedFile;
  //     XFile? file;
  //     if (result != null && result is int) {
  //       if (result == 1) {
  //         file = await ImagePicker().pickImage(source: ImageSource.camera);
  //         if (file != null) {
  //           String? imagePath = file.path;
  //
  //           selectedFile = File(imagePath);
  //         }
  //         Get.back();
  //       }
  //       if (result == 2) {
  //         file = await ImagePicker().pickImage(source: ImageSource.gallery);
  //         if (file != null) {
  //           String? imagePath = file.path;
  //           selectedFile = File(imagePath);
  //         }
  //       }
  //     }
  //     return selectedFile;
  //   }
  // }

  static showConfirmDialog(
      {required String title,
      required String content,
      required Function onOk,
      required Function onNo,
      String noTitle = "No",
      String okTitle = "Ok",
      bool showTransparentColors = true}) async {
    await showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: AlertDialog(
            insetPadding:
                const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            title: Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
              ),
            ),
            content: Text(
              content,
              style: const TextStyle(
                color: AppColors.white,
                height: 24 / 16,
              ),
            ),
            // backgroundColor: showTransparentColors ? AppColors.blurGrayColor:AppColors.filterBottomSheetColor,
            backgroundColor: AppColors.filterBottomSheetColor,
            actions: <Widget>[
              ThemeButton(
                height: 38,
                text: noTitle,
                width: 90,
                onPressed: () {
                  Get.back();
                  onNo();
                },
              ),
              ThemeButton(
                height: 38,
                text: okTitle,
                width: 90,
                onPressed: () {
                  Get.back();
                  onOk();
                },
              )
            ],
          ),
        );
      },
    );
  }

}

