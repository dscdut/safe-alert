import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_template/common/constants/ads_ids/android_ads_ids.dart';
import 'package:flutter_template/common/constants/ads_ids/android_test_ads_ids.dart';
import 'package:flutter_template/common/constants/ads_ids/ios_ads_ids.dart';
import 'package:flutter_template/common/constants/ads_ids/ios_test_ads_ids.dart';
import 'package:flutter_template/flavors.dart';
import 'package:flutter_template/router/app_router.dart';

abstract final class AdsIdsHelper {
  static String getBannerAdsId(BuildContext context) {
    if (Platform.isAndroid) {
      return switch (AppFlavor.appFlavor) {
        Flavor.PROD => _getAndroidProductionBannerAdsId(context),
        _ => AndroidTestAdsIds.BANNER,
      };
    } else if (Platform.isIOS) {
      return switch (AppFlavor.appFlavor) {
        Flavor.PROD => _getIosProductionBannerAdsId(context),
        _ => IosTestAdsIds.BANNER,
      };
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // Add your android banner ads ids here for each route
  static String _getAndroidProductionBannerAdsId(BuildContext context) {
    return switch (ModalRoute.of(context)?.settings.name) {
      AppRouter.root => AndroidAdsIds.BANNER_HOME,
      _ => AndroidAdsIds.BANNER_HOME,
    };
  }

  // Add your ios banner ads ids here for each route
  static String _getIosProductionBannerAdsId(BuildContext context) {
    return switch (ModalRoute.of(context)?.settings.name) {
      AppRouter.root => IosAdsIds.BANNER_HOME,
      _ => IosAdsIds.BANNER_HOME,
    };
  }

  static String getNativeAdsId(BuildContext context) {
    if (Platform.isAndroid) {
      return switch (AppFlavor.appFlavor) {
        Flavor.PROD => _getAndroidProductionNativeAdsId(context),
        _ => AndroidTestAdsIds.NATIVE,
      };
    } else if (Platform.isIOS) {
      return switch (AppFlavor.appFlavor) {
        Flavor.PROD => _getIosProductionNativeAdsId(context),
        _ => IosTestAdsIds.NATIVE,
      };
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // Add your android native ads ids here for each route
  static String _getAndroidProductionNativeAdsId(BuildContext context) {
    return switch (ModalRoute.of(context)?.settings.name) {
      AppRouter.root => AndroidAdsIds.NATIVE_HOME,
      _ => AndroidAdsIds.NATIVE_HOME,
    };
  }

  // Add your ios native ads ids here for each route
  static String _getIosProductionNativeAdsId(BuildContext context) {
    return switch (ModalRoute.of(context)?.settings.name) {
      AppRouter.root => IosAdsIds.NATIVE_HOME,
      _ => IosAdsIds.NATIVE_HOME,
    };
  }

  static String getInterstitialAdsId(BuildContext context) {
    if (Platform.isAndroid) {
      return switch (AppFlavor.appFlavor) {
        Flavor.PROD => _getAndroidProductionInterstitialAdsId(context),
        _ => AndroidTestAdsIds.INTERSTITIAL,
      };
    } else if (Platform.isIOS) {
      return switch (AppFlavor.appFlavor) {
        Flavor.PROD => _getIosProductionInterstitialAdsId(context),
        _ => IosTestAdsIds.INTERSTITIAL,
      };
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // Add your android interstitial ads ids here for each route
  static String _getAndroidProductionInterstitialAdsId(BuildContext context) {
    return switch (ModalRoute.of(context)?.settings.name) {
      AppRouter.root => AndroidAdsIds.INTERSTITIAL_HOME,
      _ => AndroidAdsIds.INTERSTITIAL_HOME,
    };
  }

  // Add your ios interstitial ads ids here for each route
  static String _getIosProductionInterstitialAdsId(BuildContext context) {
    return switch (ModalRoute.of(context)?.settings.name) {
      AppRouter.root => IosAdsIds.INTERSTITIAL_HOME,
      _ => IosAdsIds.INTERSTITIAL_HOME,
    };
  }

  static String getAppOpenAdsId(BuildContext context) {
    if (Platform.isAndroid) {
      return switch (AppFlavor.appFlavor) {
        Flavor.PROD => _getAndroidProductionOpenAppAdsId(context),
        _ => AndroidTestAdsIds.OPEN_APP,
      };
    } else if (Platform.isIOS) {
      return switch (AppFlavor.appFlavor) {
        Flavor.PROD => _getIosProductionOpenAppAdsId(context),
        _ => IosTestAdsIds.OPEN_APP,
      };
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // Add your android open app ads ids here for each route
  static String _getAndroidProductionOpenAppAdsId(BuildContext context) {
    return switch (ModalRoute.of(context)?.settings.name) {
      AppRouter.root => AndroidAdsIds.OPEN_APP_HOME,
      _ => AndroidAdsIds.OPEN_APP_HOME,
    };
  }

  // Add your ios open app ads ids here for each route
  static String _getIosProductionOpenAppAdsId(BuildContext context) {
    return switch (ModalRoute.of(context)?.settings.name) {
      AppRouter.root => IosAdsIds.OPEN_APP_HOME,
      _ => IosAdsIds.OPEN_APP_HOME,
    };
  }

  static String getRewardedAdsId(BuildContext context) {
    if (Platform.isAndroid) {
      return switch (AppFlavor.appFlavor) {
        Flavor.PROD => _getAndroidProductionRewardedAdsId(context),
        _ => AndroidTestAdsIds.REWARDED,
      };
    } else if (Platform.isIOS) {
      return switch (AppFlavor.appFlavor) {
        Flavor.PROD => _getIosProductionRewardedAdsId(context),
        _ => IosTestAdsIds.REWARDED,
      };
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // Add your android rewarded ads ids here for each route
  static String _getAndroidProductionRewardedAdsId(BuildContext context) {
    return switch (ModalRoute.of(context)?.settings.name) {
      AppRouter.root => AndroidAdsIds.REWARDED_HOME,
      _ => AndroidAdsIds.REWARDED_HOME,
    };
  }

  // Add your ios rewarded ads ids here for each route
  static String _getIosProductionRewardedAdsId(BuildContext context) {
    return switch (ModalRoute.of(context)?.settings.name) {
      AppRouter.root => IosAdsIds.REWARDED_HOME,
      _ => IosAdsIds.REWARDED_HOME,
    };
  }

  static String getRewardedInterstitialAdsId(BuildContext context) {
    if (Platform.isAndroid) {
      return switch (AppFlavor.appFlavor) {
        Flavor.PROD => _getAndroidProductionRewardedInterstitialAdsId(context),
        _ => AndroidTestAdsIds.REWARDED_INTERSTITIAL,
      };
    } else if (Platform.isIOS) {
      return switch (AppFlavor.appFlavor) {
        Flavor.PROD => _getIosProductionRewardedInterstitialAdsId(context),
        _ => IosTestAdsIds.REWARDED_INTERSTITIAL,
      };
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // Add your android rewarded ads ids here for each route
  static String _getAndroidProductionRewardedInterstitialAdsId(BuildContext context) {
    return switch (ModalRoute.of(context)?.settings.name) {
      AppRouter.root => AndroidAdsIds.REWARDED_INTERSTITIAL_HOME,
      _ => AndroidAdsIds.REWARDED_INTERSTITIAL_HOME,
    };
  }

  // Add your ios rewarded ads ids here for each route
  static String _getIosProductionRewardedInterstitialAdsId(BuildContext context) {
    return switch (ModalRoute.of(context)?.settings.name) {
      AppRouter.root => IosAdsIds.REWARDED_INTERSTITIAL_HOME,
      _ => IosAdsIds.REWARDED_INTERSTITIAL_HOME,
    };
  }
}
