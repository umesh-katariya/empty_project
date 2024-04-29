import 'package:get/get.dart';
import 'fcm_service.dart';

class NotificationService extends GetxService {
  static NotificationService get instance => Get.find();

  Future<void> redirect(String? notification) async {

  }

  void onNotificationTap() {
    appClosednotificationController.stream.listen((event) {
      final message = event;
      redirect(message);
    });
  }
}

