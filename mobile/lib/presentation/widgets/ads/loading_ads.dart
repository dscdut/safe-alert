import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/color_styles.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';

class LoadingAds extends StatelessWidget {
  final double size;

  const LoadingAds({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: ColorStyles.antiFlashWhite,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: size * 1.1,
                height: size * 1.1,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(size),
                child: Assets.icons.launcher.appIcon.image(width: size, height: size),
              ),
            ],
          ),
          AppSize.h20,
          Text(
            LocaleKeys.loading_ads.tr(),
            style: context.bodyLarge.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
