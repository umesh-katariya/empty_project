import 'package:flutter/material.dart';

/// Get screen media.
final MediaQueryData media =
// ignore: deprecated_member_use
MediaQueryData.fromView(WidgetsBinding.instance.window);

/// This extention help us to make widget responsive.
extension NumberParsing on num {
  double w() => this * media.size.width / 100;

  double h() => this * media.size.height / 100;
}