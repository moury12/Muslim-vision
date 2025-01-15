import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const homeScreenBannerUnitId = 'ca-app-pub-5328913902241249/9455020243';

class AdMobService {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return homeScreenBannerUnitId;
    } else if (Platform.isIOS) {
      return '';
    }
    return null;
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('++++++ ad Loaded ++++++'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('xxxxx ad Failed to Load xxxxx :$error');
    },
    onAdOpened: (ad) => debugPrint('++++ ad Openned ++++'),
    onAdClosed: (ad) => debugPrint('++++ ad Closed ++++'),
  );
}
