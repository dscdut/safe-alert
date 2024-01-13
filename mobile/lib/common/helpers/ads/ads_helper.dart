import 'package:flutter/material.dart';
import 'package:flutter_template/presentation/widgets/ads/loading_ads.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdsHelper {
  AdWithoutView? adWithoutView;

  int numOfLoadAttempts;
  final int maxNumOfLoadAttempts;

  AdsHelper({this.numOfLoadAttempts = 0, required this.maxNumOfLoadAttempts});

  Future<void> preloadAds({
    required BuildContext context,
    String? id,
    void Function()? onAdLoaded,
    void Function()? onAdFailedToLoad,
  });

  void setAd({required AdWithoutView ad, required void Function()? onAdLoaded}) {
    numOfLoadAttempts = 0;
    adWithoutView = ad;

    onAdLoaded?.call();
  }

  void handleAdFailedToLoad({required BuildContext context, String? id, required void Function()? onAdFailedToLoad}) {
    if (onAdFailedToLoad == null) {
      adWithoutView = null;

      if (numOfLoadAttempts < maxNumOfLoadAttempts) {
        ++numOfLoadAttempts;
        preloadAds(context: context, id: id);
      }
    } else {
      onAdFailedToLoad.call();
    }
  }

  void showAds({
    required BuildContext context,
    void Function()? onAdShowedFullScreenContent,
    void Function()? onAdFailedToShowFullScreenContent,
    void Function()? onAdDismissedFullScreenContent,
    void Function()? onAdClicked,
    void Function(AdWithoutView, RewardItem)? onUserEarnedReward,
  }) {
    if (adWithoutView == null) {
      showDialog(
        context: context,
        builder: (context) {
          return const Dialog.fullscreen(child: LoadingAds(size: 100));
        },
      );

      preloadAds(
        context: context,
        onAdLoaded: () {
          Navigator.pop(context);

          showFullScreenContent(
            onAdShowedFullScreenContent: onAdShowedFullScreenContent,
            onAdFailedToShowFullScreenContent: onAdFailedToShowFullScreenContent,
            onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
            onAdClicked: onAdClicked,
            onUserEarnedReward: onUserEarnedReward,
          ).then((value) => preloadAds(context: context));
        },
        onAdFailedToLoad: () {
          Navigator.pop(context);
        },
      ).catchError((_) {
        Navigator.pop(context);
      });
    } else {
      showFullScreenContent(
        onAdShowedFullScreenContent: onAdShowedFullScreenContent,
        onAdFailedToShowFullScreenContent: onAdFailedToShowFullScreenContent,
        onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
        onAdClicked: onAdClicked,
        onUserEarnedReward: onUserEarnedReward,
      ).then((value) => preloadAds(context: context));
    }
  }

  Future<void> showFullScreenContent({
    required void Function()? onAdShowedFullScreenContent,
    required void Function()? onAdFailedToShowFullScreenContent,
    required void Function()? onAdDismissedFullScreenContent,
    required void Function()? onAdClicked,
    required void Function(AdWithoutView, RewardItem)? onUserEarnedReward,
  }) {
    if (adWithoutView is AppOpenAd) {
      final ad = adWithoutView as AppOpenAd;

      ad.fullScreenContentCallback = _getContentCallback<AppOpenAd>(
        onAdClicked: onAdClicked,
        onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
        onAdFailedToShowFullScreenContent: onAdFailedToShowFullScreenContent,
        onAdShowedFullScreenContent: onAdShowedFullScreenContent,
      );

      return ad.show();
    } else if (adWithoutView is InterstitialAd) {
      final ad = adWithoutView as InterstitialAd;

      ad.fullScreenContentCallback = _getContentCallback<InterstitialAd>(
        onAdClicked: onAdClicked,
        onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
        onAdFailedToShowFullScreenContent: onAdFailedToShowFullScreenContent,
        onAdShowedFullScreenContent: onAdShowedFullScreenContent,
      );

      return ad.show();
    } else if (adWithoutView is RewardedAd) {
      final ad = adWithoutView as RewardedAd;

      ad.fullScreenContentCallback = _getContentCallback<RewardedAd>(
        onAdClicked: onAdClicked,
        onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
        onAdFailedToShowFullScreenContent: onAdFailedToShowFullScreenContent,
        onAdShowedFullScreenContent: onAdShowedFullScreenContent,
      );

      return ad.show(onUserEarnedReward: (ad, item) => onUserEarnedReward?.call(ad, item));
    }

    return Future(() => {});
  }

  FullScreenContentCallback<T> _getContentCallback<T extends AdWithoutView>({
    required void Function()? onAdShowedFullScreenContent,
    required void Function()? onAdFailedToShowFullScreenContent,
    required void Function()? onAdDismissedFullScreenContent,
    required void Function()? onAdClicked,
  }) {
    return FullScreenContentCallback<T>(
      onAdShowedFullScreenContent: (_) => onAdShowedFullScreenContent?.call(),
      onAdFailedToShowFullScreenContent: (ad, __) {
        ad.dispose();

        onAdFailedToShowFullScreenContent?.call();
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();

        onAdDismissedFullScreenContent?.call();
      },
      onAdClicked: (_) => onAdClicked?.call(),
    );
  }
}
