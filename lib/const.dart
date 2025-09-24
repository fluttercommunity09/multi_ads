import 'dart:ui';

import 'package:multiads/ads/src/multi_ads_factory.dart';

class Constants {
  static const jsonConfigUrl =
      'https://drive.google.com/uc?export=download&id=1GbG_59qBnr_wMPjDJpv7yOyCU_gAr9G8';

  static Color mainColor = const Color(0xff33FD24);
}

late Map<String, dynamic> configApp;
late MultiAds gAds;
late bool isInterShowed;
