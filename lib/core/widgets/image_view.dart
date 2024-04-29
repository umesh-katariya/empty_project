import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../app_theme/app_colors.dart';
import '../utils/app_assets.dart';

enum ImageType { asset, file, url, svg }

class ImageView extends StatefulWidget {
  String? path;
  ImageType type;
  double? height, width;
  String? placeHolderImagePath;
  BoxFit? fit;
  Color? color;

  bool isBigImage = false;

  ImageView(
    this.path,
    this.type, {
    super.key,
    this.height,
    this.width,
    this.color,
    this.placeHolderImagePath = AppAssets.profileIcon,
    this.fit,
    this.isBigImage = false,
  }) {
    if (placeHolderImagePath == null || placeHolderImagePath!.isEmpty) {
      placeHolderImagePath = AppAssets.profileIcon;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return ImageState();
  }
}

class ImageState extends State<ImageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return showImage(
      widget.path,
      widget.type,
      widget.height,
      widget.width,
      widget.placeHolderImagePath,
      widget.fit,
    );
  }

  Widget showImage(String? path, ImageType type, double? height, double? width,
      String? placeHolderImagePath, BoxFit? fit) {

    switch (type) {
      case ImageType.asset:
        try {
          return Image.asset(
            path!,
            height: height,
            width: width,
            fit: fit,
            color: widget.color,
            opacity: const AlwaysStoppedAnimation(1),
          );
        } catch (e) {
          print(e);
          return placeHolder(height, width, placeHolderImagePath!, fit);
        }

      case ImageType.svg:
        try {
          return SvgPicture.asset(
            path!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            colorFilter: widget.color != null
                ? ColorFilter.mode(
                    widget.color ?? AppColors.black, BlendMode.srcIn)
                : null,
          );
        } catch (e) {
          print(e);
          return placeHolder(height, width, placeHolderImagePath!, fit);
        }

      case ImageType.file:
        try {
          File f = File(path!);
          if (f.existsSync()) {
            return Image.file(
              f,
              height: height,
              width: width,
              fit: fit,
              opacity: const AlwaysStoppedAnimation(1),
            );
          } else {
            return placeHolder(height, width, placeHolderImagePath!, fit);
          }
        } catch (e) {
          print(e);
          return placeHolder(height, width, placeHolderImagePath!, fit);
        }

      case ImageType.url:
        try {
          return SizedBox(
            width: width,
            /*child: Image.network(
              path ?? "",
              fit: fit,
              height: height,
              width: width,
              errorBuilder: (context, error, stackTrace) {
                return placeHolder(height, width, placeHolderImagePath!, fit);
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                        color: AppColors.primaryColor,
                      ));
                }
              },
            ),*/
            child: CachedNetworkImage(
                imageUrl: path ?? "",
                cacheKey:
                    (path ?? "").contains("https://storage.googleapis.com/")
                        ? ((path ?? "").isEmpty
                            ? ""
                            : getAWSS3BaseImageUrl(path ?? ""))
                        : path,
                errorWidget: (context, url, error) {
                  return placeHolder(height, width, placeHolderImagePath!, fit);
                },
                height: height,
                fit: fit,
                imageBuilder: (context, imageProvioder) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: imageProvioder, fit: fit),
                    ),
                  );
                },
                memCacheWidth: (Get.width * .8).toInt(),
                placeholderFadeInDuration: const Duration(milliseconds: 500),
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: AppColors.primaryColor,
                      ));
                  // return Container(
                  //   height: 200,
                  //   alignment: Alignment.center,
                  //   margin: const EdgeInsets.only(top: 100, bottom: 100),
                  //   child: CircularProgressIndicator(
                  //     // value: downloadProgress.progress,
                  //     color: AppColors.appRed,
                  //   ),
                  // );
                }),
          );
        } catch (e) {
          print(e);
          return placeHolder(height, width, placeHolderImagePath!, fit);
        }
    }
  }

  String getAWSS3BaseImageUrl(String fullUrl) {
    RegExp regExp = RegExp(r'(^[^?]+)');
    Match? match = regExp.firstMatch(fullUrl);

    return match?.group(1) ?? '';
  }

  Widget placeHolder(
      double? height, double? width, String placeHolderImagePath, BoxFit? fit) {
    return SvgPicture.asset(
      placeHolderImagePath,
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
    );
  }
}
