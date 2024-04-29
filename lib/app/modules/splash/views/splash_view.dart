
import 'package:empty_project/core/app_theme/app_colors.dart';
import 'package:empty_project/core/widgets/app_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (context) {
          return AppScaffold(
            resizeToAvoidBottomInset: false,
            bodyPadding: EdgeInsets.zero,
            body: Container(
              color: AppColors.white,
            ),
          );
        }
    );
  }
}