import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_theme/app_colors.dart';
import '../utils/app_assets.dart';
import 'app_scaffold.dart';
import 'image_view.dart';

class FullImageView extends StatelessWidget {
  String path;
  ImageType imageType;

  FullImageView({super.key,required this.path,required this.imageType});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bodyPadding: EdgeInsets.zero,
      body: _buildBodyView(),
    );
  }

  Widget _buildBodyView() {
    return SafeArea(
      child: Stack(
        children: [
          ImageView(
            path,
            imageType,
            fit: BoxFit.contain,
            height: MediaQuery.of(Get.context!).size.height,
            width: MediaQuery.of(Get.context!).size.width,
          ),
          Positioned(
              top: 5,
              left : 5,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: ImageView(
                    AppAssets.closeIcon,
                    ImageType.svg,
                  )))
        ],
      ),
    );
  }
}
