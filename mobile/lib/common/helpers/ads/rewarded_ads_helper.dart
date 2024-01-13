import 'package:flutter/material.dart';
import 'package:flutter_template/common/helpers/ads/ads_helper.dart';
import 'package:flutter_template/common/helpers/ads/ads_ids_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdsHelper extends AdsHelper {
  static final RewardedAdsHelper _instance = RewardedAdsHelper._(maxNumOfLoadAttempts: 3);

  factory RewardedAdsHelper() {
    return _instance;
  }

  RewardedAdsHelper._({required super.maxNumOfLoadAttempts});

  @override
  Future<void> preloadAds({
    required BuildContext context,
    String? id,
    void Function()? onAdLoaded,
    void Function()? onAdFailedToLoad,
  }) {
    return RewardedAd.load(
      adUnitId: id ?? AdsIdsHelper.getRewardedAdsId(context),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
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
