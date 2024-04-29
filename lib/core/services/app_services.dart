import 'dart:async';
import 'package:get/get.dart';
import '../../app/data/ws/url_utils.dart';
import '../firebase_utils/dynamic_link_handler.dart';
import '../socket_utils/socket_helper.dart';
import 'notification_services.dart';

class AppService extends GetxService {
  static AppService get instance => Get.find();

  late SocketHelper socketHelper;

  Future<AppService> init() async {
    // Load notification controller and services.
    Get.put(NotificationService());

    DynamicLinkHandler().initDynamicLinks();

    return this;
  }

  void onConnect() async {
    print('Socket Connect connect');

    socketHelper.emitData(SocketEvents.registerFCMToken, {"fcmToken": "token"});

    socketHelper.listenEvent("registerFCMToken", (p0) {
      print("object-- registerFCMToken $p0");
    });
  }

  void initSocket({String? token}) async {
    try {
      socketHelper = SocketHelper(UrlUtils.socketUrl, token: token);
      socketHelper.connect(
        token: token,
        onConnect: onConnect,
        onConnectError: (error) async {
          print('Socket Connect Error : $error');
        },
        onConnectTimeout: (error) async {
          print('Socket Connect Timeout : $error');
        },
        onDisconnect: () async {
          print('Socket Connect Disconnect');
          //reconnectSocket();
        },
      );
    } catch (e) {
      print('Socket connect Error : $e');
    }
  }


  @override
  void onClose() {
    super.onClose();
  }

}
