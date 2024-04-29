import 'package:empty_project/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/services/app_services.dart';
import 'core/services/fcm_service.dart';
import 'core/utils/storage_utils.dart';
import 'firebase_options.dart';

void main() async {
  startApp();
}

void startApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// Initializes the Firebase app with the provided options.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initializeFireBase();

  await GetStorage.init(StorageKeys.containerKey);

  await Get.putAsync<AppService>(() async => await AppService().init());
  runApp(
    // TODO: Flavour setup for development with device preview.
    // DevicePreview(
    //   enabled: true,
    //   builder: (context) {
    //     return const SpeedTurtleApp();
    //   },
    // ),
    const App(),
  );
}
