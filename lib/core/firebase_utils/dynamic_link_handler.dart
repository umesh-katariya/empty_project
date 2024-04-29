import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../logger/app_logger.dart';

class DynamicLinkHandler {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  Future<void> initDynamicLinks() async {
    AppLog.i("Starting dynamic links listener");
    dynamicLinks.onLink.listen((dynamicLinkData) {
      // Listen and retrieve dynamic links here
      final String deepLink = dynamicLinkData.link.toString(); // Get DEEP LINK
      // Ex: https://namnp.page.link/product/013232
      final Map<String, String> queryParameters =
          dynamicLinkData.link.queryParameters; // Get PATH

      if (deepLink.isEmpty) return;
      handleDeepLink(queryParameters);
    }).onError((error) {
      AppLog.e('onLink error');
      AppLog.e(error.message);
    });
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    try {
      final initialLink = await dynamicLinks.getInitialLink();
      if (initialLink == null) return;
      handleDeepLink(initialLink.link.queryParameters);
    } catch (e) {
      // Error
    }
  }

  void handleDeepLink(Map<String, String> data) {
    // navigate to specific screen location
    AppLog.prettyPrint(data);
    if (data.isNotEmpty && data.containsKey("link_type")) {
      switch (data['link_type']) {
        case 'INVITE_USER':

          break;

        default:
      }
    }
  }
}
