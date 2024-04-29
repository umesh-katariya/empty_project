import 'package:flutter/material.dart';

import '../app_theme/app_colors.dart';
import 'text_view.dart';

class AppRaisedButton extends StatelessWidget {
  String? title;
  Widget? child;
  Color? color;
  Color? borderColor;
  double? height;
  double? width;
  BoxConstraints? constraints;
  double borderRadius;
  Color titleColor;
  double titleSize;
  FontWeight? titleFontWeight;
  int titleMaxLines;
  TextAlign titleAlign;
  double elevation;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  VoidCallback? onPressed;
  bool isOutlineButton;
  TextOverflow? textOverflow;
  Color? shadowColor;
  LinearGradient? linearGradient;
  Decoration? decoration;

  AppRaisedButton({
    Key? key,
    this.title,
    this.child,
    this.color = AppColors.primaryColor,
    this.borderColor,
    this.height,
    this.width,
    this.constraints,
    this.borderRadius = 8,
    this.titleColor = AppColors.white,
    this.titleSize = 16,
    this.titleFontWeight,
    this.titleMaxLines = 1,
    this.titleAlign = TextAlign.center,
    this.elevation = 1.0,
    this.padding,
    this.margin,
    this.onPressed,
    this.textOverflow,
    this.isOutlineButton = false,
    this.shadowColor,
    this.decoration,
    this.linearGradient,
  }) : super(key: key) {
    if (isOutlineButton) {
      elevation = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      decoration: decoration,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlineButton ? AppColors.primaryColor : color,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: isOutlineButton
              ? BorderSide(
                  color: AppColors.outlineBorderColor,
                  width: isOutlineButton ? 2 : 0,
                )
              : null,
          textStyle: TextStyle(
            color: titleColor,
            fontSize: titleSize,
            fontWeight: titleFontWeight ?? FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: 3)
                  : BorderSide.none),
          elevation: elevation,
          padding: padding,
          shadowColor: shadowColor,
        ),
        onPressed: onPressed,
        child: title != null
            ? TextView(
                title!,
                maxLines: titleMaxLines,
                textAlign: titleAlign,
                textColor: isOutlineButton ? AppColors.white : titleColor,
                fontWeight: titleFontWeight ?? FontWeight.w600,
                fontSize: titleSize,
                textOverflow: textOverflow,
              )
            : child,
      ),
    );
  }
}
