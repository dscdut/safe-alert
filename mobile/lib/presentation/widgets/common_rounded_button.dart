import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/common/theme/color_styles.dart';
import 'package:flutter_template/presentation/widgets/loading_dot.dart';

class CommonRoundedButton extends StatelessWidget {
  const CommonRoundedButton({
    Key? key,
    required this.onPressed,
    this.width,
    this.height = 48,
    this.borderRadius = 30.0,
    this.elevation = 0,
    this.backgroundColor = ColorStyles.primaryColor,
    this.disableBackgroundColor = ColorStyles.gray300,
    this.shadowColor,
    required this.content,
    this.textStyle,
    this.isDisable = false,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.child,
    this.borderSide,
  }) : super(key: key);

  final VoidCallback onPressed;

  final double? width;
  final double height;
  final double borderRadius;
  final double elevation;

  final Color backgroundColor;
  final Color disableBackgroundColor;
  final Color? shadowColor;

  final String content;

  final TextStyle? textStyle;

  final bool isLoading;
  final bool isDisable;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? child;

  final BorderSide? borderSide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Theme(
        data: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(
                isDisable ? disableBackgroundColor : backgroundColor,
              ),
              foregroundColor: MaterialStateProperty.all<Color>(
                isDisable ? disableBackgroundColor : backgroundColor,
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                isDisable ? disableBackgroundColor : backgroundColor,
              ),
              elevation: MaterialStateProperty.resolveWith<double>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.focused)) {
                    return 0;
                  }

                  return elevation;
                },
              ),
            ),
          ),
        ),
        child: ElevatedButton(
          onPressed: (isLoading || isDisable) ? null : onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: borderSide ?? BorderSide.none,
            ),
            shadowColor: shadowColor,
            splashFactory: NoSplash.splashFactory,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            disabledBackgroundColor: disableBackgroundColor,
            disabledForegroundColor: disableBackgroundColor,
            enableFeedback: false,
          ),
          child: isLoading
              ? const LoadingDot()
              : (child ??
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (prefixIcon != null)
                          Row(
                            children: [
                              prefixIcon!,
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        Text(
                          content,
                          style: textStyle ?? context.labelLarge.copyWith(fontSize: 18.0, color: context.themeConfig.onPrimaryTextColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (suffixIcon != null)
                          Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              suffixIcon!,
                            ],
                          ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
