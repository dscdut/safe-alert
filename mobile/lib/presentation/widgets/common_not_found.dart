import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/generated/assets.gen.dart';

class CommonNotFound extends StatelessWidget {
  const CommonNotFound({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.images.lottie.searchNotFound.lottie(
          width: context.width / 2,
        ),
        Text(
          text,
          style: context.bodyLarge.copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
