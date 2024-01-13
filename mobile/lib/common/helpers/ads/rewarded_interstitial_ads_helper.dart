import 'package:flutter/material.dart';
import 'package:flutter_template/common/helpers/ads/ads_helper.dart';
import 'package:flutter_template/common/helpers/ads/ads_ids_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedInterstitialAdsHelper extends AdsHelper {
  static final RewardedInterstitialAdsHelper _instance = RewardedInterstitialAdsHelper._(maxNumOfLoadAttempts: 3);

  factory RewardedInterstitialAdsHelper() {
    return _instance;
  }

  RewardedInterstitialAdsHelper._({required super.maxNumOfLoadAttempts});

  @override
  Future<void> preloadAds({
    required BuildContext context,
    String? id,
    void Function()? onAdLoaded,
    void Function()? onAdFailedToLoad,
  }) {
    return RewardedInterstitialAd.load(
      adUnitId: id ?? AdsIdsHelper.getRewardedInterstitialAdsId(context),
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
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
