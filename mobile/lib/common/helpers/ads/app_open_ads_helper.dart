import 'package:flutter/material.dart';
import 'package:flutter_template/common/helpers/ads/ads_helper.dart';
import 'package:flutter_template/common/helpers/ads/ads_ids_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdsHelper extends AdsHelper {
  static final AppOpenAdsHelper _instance = AppOpenAdsHelper._(maxNumOfLoadAttempts: 3);

  factory AppOpenAdsHelper() {
    return _instance;
  }

  AppOpenAdsHelper._({required super.maxNumOfLoadAttempts});

  @override
  Future<void> preloadAds({
    required BuildContext context,
    String? id,
    void Function()? onAdLoaded,
    void Function()? onAdFailedToLoad,
  }) {
    return AppOpenAd.load(
      adUnitId: id ?? AdsIdsHelper.getAppOpenAdsId(context),
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd ad) {
          super.setAd(ad: ad, onAdLoaded: onAdLoaded);
        },
        onAdFailedToLoad: (LoadAdError error) {
          super.handleAdFailedToLoad(context: context, id: id, onAdFailedToLoad: onAdFailedToLoad);
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    );
  }
}
