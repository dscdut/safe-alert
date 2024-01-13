import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/color_styles.dart';
import 'package:flutter_template/presentation/widgets/common_icon_button.dart';

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonIconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icons.chevron_left_rounded,
      iconColor: ColorStyles.primary,
    );
  }
}
