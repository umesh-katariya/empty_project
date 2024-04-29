import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_theme/app_colors.dart';
import 'constants.dart';

class TextStyles {
  static Text normal({required String text, required Color color}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: null,
      style: TextStyle(
        fontSize: 14.sp,
        color: color,
      ),
    );
  }

  //! Body Text style
  static TextStyle bodyText1({Color? color}) {
    return TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.blackColor);
  }

  static TextStyle bodyText2({Color? color, bool isBold = false}) {
    return TextStyle(
        fontSize: 15.sp,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        color: color ?? AppColors.blackColor);
  }

  static TextStyle bodyText3({Color? color}) {
    return TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.blackColor);
  }

  static TextStyle bodyText4({Color? color}) {
    return TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.blackColor);
  }

  static TextStyle bodyText5({Color? color}) {
    return TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.blackColor);
  }

  static TextStyle filterScreenText({Color? color}) {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: color ?? AppColors.onPrimaryColor,
    );
  }

  static TextStyle bodyText({Color? color}) {
    return TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.filterTextColor);
  }
  static TextStyle categoryText({Color? color}) {
    return TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.filterTextColor);
  }

  static TextStyle filterText({Color? color}) {
    return TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.onSecondaryColor);
  }
  static TextStyle advancedFilterText({Color? color}) {
    return TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.onSecondaryColor);
  }

  /// MainHeader1
  /// font size: 20.sp
  /// font weight: FontWeight.w700
  /// color: AppColors.onPrimaryColor
  static TextStyle mainHeader1({Color? color}) {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.onPrimaryColor,
    );
  }

  /// MainHeader2
  /// font size: 16.sp
  /// font weight: FontWeight.w400
  /// color: AppColors.gray2Color
  static TextStyle mainHeader2() {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.gray2Color,
    );
  }

  static TextStyle headlineLarge({Color? color}) {
    return  TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w600,
    );
  }
}
