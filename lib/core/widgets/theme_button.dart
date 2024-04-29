import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../app_theme/app_colors.dart';
import '../utils/text_style.dart';

class ThemeButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final String? icon;
  final bool showIcon;
  final Function() onPressed;
  final bool enable;

  const ThemeButton({
    Key? key,
    required this.height,
    required this.text,
    required this.width,
    required this.onPressed,
    this.icon,
    this.showIcon = false,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(height)),
        gradient: LinearGradient(
          colors: [
            enable ? AppColors.primaryColor : AppColors.dividerColor,
            enable ? AppColors.secondaryColor : AppColors.dividerColor.withOpacity(0.5),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(height),
            splashColor: AppColors.primaryColor,
            onTap: enable ? onPressed : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showIcon && icon != null) ...[
                  SvgPicture.asset(
                    icon!,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CCIconButton extends StatelessWidget {
  final String title;
  final double buttonHeight;
  final double? buttonWidth;
  final EdgeInsets? padding;
  final Color color;
  final Color? borderColor;
  final Function() onTap;
  final bool shadow;
  final bool showBorder;
  final Widget? icon;
  final TextStyle? style;
  final BorderRadius? radius;
  final Color textColor;

  const CCIconButton(
      {Key? key,
      this.buttonHeight = 51,
      required this.onTap,
      required this.title,
      this.padding,
      this.color = AppColors.secondaryColor,
      this.shadow = true,
      this.buttonWidth = double.maxFinite,
      this.showBorder = false,
      this.style,
      this.icon,
      this.radius,
      this.borderColor,
      this.textColor = AppColors.blackColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius ?? BorderRadius.circular(12.r),
        color: color,
        border: showBorder
            ? Border.all(color: borderColor ?? AppColors.secondaryColor, width: 1)
            : null,
        boxShadow: shadow
            ? [
                BoxShadow(
                  blurRadius: 16,
                  spreadRadius: 0,
                  offset: const Offset(0, 6),
                  color: AppColors.blackColor.withOpacity(0.4),
                )
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius ?? BorderRadius.circular(12.r),
          splashColor: AppColors.primaryColor,
          child: Container(
            width: buttonWidth,
            height: buttonHeight,
            padding: padding,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon ?? Container(),
                  const SizedBox(
                    width: 6,
                  ),
                ],
                Text(
                  title,
                  style: style ?? TextStyles.bodyText3(color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeIconButton extends StatelessWidget {
  final Function() onPressed;
  final String icon;

  const ThemeIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: const LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.secondaryColor,
              ],
            ),
          ),
          padding: const EdgeInsets.all(1),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.all(13),
            child: SvgPicture.asset(
              icon,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
