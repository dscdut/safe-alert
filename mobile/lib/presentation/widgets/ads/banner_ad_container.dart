import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/enums/load_ads_status.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/common/helpers/ads/ads_ids_helper.dart';
import 'package:flutter_template/common/theme/color_styles.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdContainer extends StatefulWidget {
  final String? adsId;
  final AdSize adSize;
  final void Function()? onAdClicked;
  final Color backgroundColor;

  const BannerAdContainer({
    super.key,
    this.adSize = AdSize.banner,
    this.adsId,
    this.onAdClicked,
    this.backgroundColor = ColorStyles.adsBackground,
  });

  @override
  State<BannerAdContainer> createState() => _BannerAdContainerState();
}

class _BannerAdContainerState extends State<BannerAdContainer> with AutomaticKeepAliveClientMixin<BannerAdContainer> {
  BannerAd? _bannerAd;
  LoadAdsStatus loadStatus = LoadAdsStatus.loading;

  @override
  void initState() {
    _bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adsId ?? AdsIdsHelper.getBannerAdsId(context),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            loadStatus = LoadAdsStatus.success;
          });
        },
        onAdFailedToLoad: (ad, error) {
          setState(() {
            loadStatus = LoadAdsStatus.failure;
          });
        },
        onAdClicked: (_) => widget.onAdClicked?.call(),
      ),
      request: const AdRequest(),
    )..load();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildLoadingCard() {
    return Container(
      height: widget.adSize.height.toDouble(),
      width: context.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      alignment: Alignment.center,
      child: Text(
        LocaleKeys.loading_ads.tr(),
        style: context.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildAds() {
    return Container(
      height: widget.adSize.height.toDouble(),
      width: context.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      child: SizedBox(
        width: widget.adSize.width.toDouble(),
        height: widget.adSize.height.toDouble(),
        child: AdWidget(
          ad: _bannerAd!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return switch (loadStatus) {
      LoadAdsStatus.loading => _buildLoadingCard(),
      LoadAdsStatus.success => _buildAds(),
      LoadAdsStatus.failure => const SizedBox.shrink(),
    };
  }
}
