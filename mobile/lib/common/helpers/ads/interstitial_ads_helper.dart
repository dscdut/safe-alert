import 'package:flutter/material.dart';
import 'package:flutter_template/common/helpers/ads/ads_helper.dart';
import 'package:flutter_template/common/helpers/ads/ads_ids_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdsHelper extends AdsHelper {
  static final InterstitialAdsHelper _instance = InterstitialAdsHelper._(maxNumOfLoadAttempts: 3);

  factory InterstitialAdsHelper() {
    return _instance;
  }

  InterstitialAdsHelper._({required super.maxNumOfLoadAttempts});

  @override
  Future<void> preloadAds({
    required BuildContext context,
    String? id,
    void Function()? onAdLoaded,
    void Function()? onAdFailedToLoad,
  }) {
    return InterstitialAd.load(
      adUnitId: id ?? AdsIdsHelper.getInterstitialAdsId(context),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          super.setAd(ad: ad, onAdLoaded: onAdLoaded);
        },
        onAdFailedToLoad: (err) {
          super.handleAdFailedToLoad(context: context, id: id, onAdFailedToLoad: onAdFailedToLoad);
        },
      ),
    );
  }
}
