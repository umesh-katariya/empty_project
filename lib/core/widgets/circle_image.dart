import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_theme/app_colors.dart';
import '../utils/app_assets.dart';
import 'image_view.dart';

class CircleImage extends StatelessWidget {
  final String? path;
  final ImageType imageType;
  final BoxFit fit;
  final double radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final ImageProvider? backgroundImage;
  final String? placeHolderImagePath;

  const CircleImage({
    super.key,
    required this.path,
    required this.imageType,
    this.fit = BoxFit.cover,
    this.radius = 50.0,
    this.backgroundColor = Colors.transparent,
    this.foregroundColor,
    this.backgroundImage,
    this.placeHolderImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      foregroundColor: foregroundColor,
      radius: radius,
      child: ClipOval(
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          height: radius * 2,
          width: radius * 2,
          child: Stack(
            children: [
              SvgPicture.asset(
                AppAssets.profileIcon,
                height: radius * 2,
                width: radius * 2,
                color: AppColors.gray2Color.withOpacity(0.2),
                fit: fit,
              ),
              ImageView(
                path,
                imageType,
                height: radius * 2,
                width: radius * 2,
                fit: fit,
                placeHolderImagePath: placeHolderImagePath,
              ),
            ],
          ),
        ),
        /*child: ImageView(
          path,
          imageType,
          height: radius * 2,
          width: radius * 2,
          fit: fit,
          placeHolderImagePath: placeHolderImagePath,
        ),*/
      ),
    );
  }
}
