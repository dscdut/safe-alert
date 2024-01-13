import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/common/enums/load_ads_status.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/common/helpers/ads/ads_ids_helper.dart';
import 'package:flutter_template/common/theme/color_styles.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdsContainer extends StatefulWidget {
  final String? adsId;
  final TemplateType templateType;
  final VoidCallback? onAdClicked;
  final double borderRadius;
  final Color backgroundColor;
  final TextStyle? textStyle;

  const NativeAdsContainer({
    super.key,
    this.adsId,
    this.templateType = TemplateType.medium,
    this.onAdClicked,
    this.borderRadius = 0,
    this.backgroundColor = Colors.white,
    this.textStyle,
  });

  @override
  State<NativeAdsContainer> createState() => _NativeAdsContainerState();
}

class _NativeAdsContainerState extends State<NativeAdsContainer>
    with AutomaticKeepAliveClientMixin<NativeAdsContainer> {
  NativeAd? nativeAd;
  LoadAdsStatus loadStatus = LoadAdsStatus.loading;

  @override
  void initState() {
    super.initState();
    nativeAd = NativeAd(
      adUnitId: widget.adsId ?? AdsIdsHelper.getNativeAdsId(context),
      listener: NativeAdListener(
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
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: widget.templateType,
        cornerRadius: widget.borderRadius,
        mainBackgroundColor: widget.backgroundColor,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          backgroundColor: ColorStyles.blue300,
          style: NativeTemplateFontStyle.bold,
          size: 17.0.sp,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: ColorStyles.blue300,
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.bold,
          size: 17.0.sp,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: ColorStyles.gray400,
          backgroundColor: Colors.transparent,
          size: 14.0.sp,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          size: 14.0.sp,
        ),
      ),
    )..load();
  }

  Widget _buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      constraints: BoxConstraints(
        minWidth: 320,
        maxWidth: 400,
        minHeight: widget.templateType == TemplateType.medium ? 320 : 90,
        maxHeight: widget.templateType == TemplateType.medium ? 400 : 200,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return switch (loadStatus) {
      LoadAdsStatus.loading => _buildContainer(
          Text(
            LocaleKeys.loading_ads.tr(),
            style: widget.textStyle ?? context.labelLarge.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      LoadAdsStatus.success => _buildContainer(AdWidget(ad: nativeAd!)),
      LoadAdsStatus.failure => const SizedBox.shrink(),
    };
  }

  @override
  bool get wantKeepAlive => true;
}
