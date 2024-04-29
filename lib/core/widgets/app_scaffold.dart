import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../app_theme/app_colors.dart';
import 'text_view.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.scaffoldKey,
    this.title = '',
    this.titleColor,
    this.subTitle = '',
    this.persistentFooterButtons,
    this.groupOnTap,
    this.onTapGroupIcon,
    this.isGroupChat = false,
    this.isCommonChat = false,
    this.bottomSheet,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endDocked,
    this.bodyPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.automaticallyImplyLeading = true,
    this.appBarLeading,
    this.actions,
    this.appBarTitle,
    this.showAppLogoinBackground = false,
    this.appBar,
    this.appBarBackgroundColor,
    this.onLeadingPressed,
    this.toolbarHeight = 80,
    this.titleSpacing,
    this.titleWidget,
    this.leadingColors = AppColors.white,
    this.statusBarIsDark = false,
    this.appbarRadius =
        const BorderRadius.vertical(bottom: Radius.circular(15)),
    this.backgroundColor = AppColors.bgColor,
    this.leadingWidth,
    Key? key,
  }) : super(key: key);

  final Key? scaffoldKey;
  final Widget body;
  final Widget? titleWidget;
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final String subTitle;
  final String? appBarTitle;
  final List<Widget>? persistentFooterButtons;
  final VoidCallback? groupOnTap;
  final VoidCallback? onTapGroupIcon;
  final VoidCallback? onLeadingPressed;
  final bool isGroupChat;
  final bool isCommonChat;
  final Widget? bottomSheet;
  final Widget? floatingActionButton;
  final bool resizeToAvoidBottomInset;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final EdgeInsets bodyPadding;
  final bool automaticallyImplyLeading;
  final Widget? appBarLeading;
  final List<Widget>? actions;
  final bool showAppLogoinBackground;
  final PreferredSize? appBar;
  final Color? appBarBackgroundColor;
  final double toolbarHeight;
  final double? leadingWidth;
  final BorderRadius appbarRadius;
  final double? titleSpacing;
  final Color? leadingColors;
  final bool statusBarIsDark;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(statusBarIsDark
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarIsDark == true
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      child:  Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: appBar ??
            (isCommonChat
                ? const PreferredSize(
                preferredSize: Size(double.maxFinite, 0),
                child: SizedBox())
                : appBarTitle != null || titleWidget != null
                ? AppBar(
              automaticallyImplyLeading:
              automaticallyImplyLeading,
              titleSpacing: titleSpacing,
              leading: automaticallyImplyLeading
                  ? IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_back,
                  color: leadingColors,
                ),
                onPressed: onLeadingPressed ?? Get.back,
              )
                  : appBarLeading,
              toolbarHeight: toolbarHeight,
              actions:actions,
              centerTitle: true,
              leadingWidth: leadingWidth,
              title: titleWidget ??
                  TextView(
                    appBarTitle,
                    fontSize: 18,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    textColor:titleColor,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                  ),
              backgroundColor: (appBarBackgroundColor ?? AppColors.appRed),
              shape: const RoundedRectangleBorder(
                borderRadius:BorderRadius.zero,
              ),
            )
                : null),
        backgroundColor: backgroundColor,
        body: _buildBody(),
        persistentFooterButtons: persistentFooterButtons,
        bottomNavigationBar: bottomSheet ?? const SizedBox.shrink(),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: bodyPadding,
      child: body,
    );
  }
}
