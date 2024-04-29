import 'package:empty_project/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'core/app_theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    final screenWidth = queryData.size.width;

    return ScreenUtilInit(
        designSize:
            screenWidth <= 430 ? const Size(375, 812) : const Size(610, 970),
        builder: (c, child) {
          return GetMaterialApp(
            title: AppStrings.appName,
            initialRoute: AppPages.initial,
            getPages: AppPages.routes,
            themeMode: ThemeMode.dark,
            darkTheme: appTheme,
            enableLog: true,
            debugShowCheckedModeBanner: false,
            builder:  (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0, ),
                child: child!,
              );
            },
          );
        });
  }
}
