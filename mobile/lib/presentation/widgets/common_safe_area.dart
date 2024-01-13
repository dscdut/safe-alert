import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/common/theme/app_size.dart';

class AppSafeArea extends StatelessWidget {
  const AppSafeArea({super.key, required this.child, this.paddingBottom = 0});
  final Widget child;
  final double paddingBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSize.horizontalSpacing,
        context.paddingTop,
        AppSize.horizontalSpacing,
        paddingBottom,
      ),
      child: child,
    );
  }
}
