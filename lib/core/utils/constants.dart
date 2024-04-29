import 'package:flutter/material.dart';

import '../app_theme/app_colors.dart';

class Constants {
  static String generateLinkPrefix = 'app.page.link';
  static String dynamicLinkUriPrefix = 'https://app.page.link';

  static const String DATE_FORMATE = 'dd/MM/yyyy';

  static OutlineInputBorder get border => OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppColors.borderColor,
    ),
    borderRadius: BorderRadius.circular(0),
  );

  static OutlineInputBorder get enableBorder => const OutlineInputBorder(
    borderSide: BorderSide(width: 2, color: Color(0xffB32B14)),
  );

}
