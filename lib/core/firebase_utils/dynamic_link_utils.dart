import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

import '../utils/app_utils.dart';
import '../utils/constants.dart';

class FirebaseDynamicLink {

  Future<Uri?> generateShareLink(String pageUrl,{bool showProgress = true}) async {

    print("generateShareLink call");

    if (showProgress) {
      await AppUtility.showProgressDialog();
    }
    DynamicLinkParameters linkParameters = DynamicLinkParameters(
      uriPrefix: Constants.dynamicLinkUriPrefix,
      link: Uri.parse(pageUrl),
      androidParameters:
          const AndroidParameters(packageName: 'com.oomph.app'),
      iosParameters: const IOSParameters(bundleId: 'com.oomph.application'),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: "Oomph",
        description: "Your friend has offered you 1 month of free premium",
        imageUrl: Uri.parse("https://storage.googleapis.com/profile-constants/oomph_logo.jpeg"),
        // imageUrl: Uri.parse(imageUrl),
      ),
    );

    Uri shareLink;
    /*if (GetPlatform.isIOS) {
      Uri urlLink =
          await FirebaseDynamicLinks.instance.buildLink(linkParameters);
      shareLink = urlLink;
    } else {
      ShortDynamicLink shortDynamicLink =
          await FirebaseDynamicLinks.instance.buildShortLink(linkParameters);
      shareLink = shortDynamicLink.shortUrl;
    }*/

    ShortDynamicLink shortDynamicLink =
    await FirebaseDynamicLinks.instance.buildShortLink(linkParameters);
    shareLink = shortDynamicLink.shortUrl;

    if (showProgress) {
      Get.close(1);
    }

    return shareLink;
  }
}
