import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/bloc/app_bloc.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/app_theme.dart';

extension ContextExtension on BuildContext {
  /// The same of [MediaQuery.of(context).size]
  Size get mediaQuerySize => MediaQuery.of(this).size;

  double get height => mediaQuerySize.height;

  double get width => mediaQuerySize.width;

  ThemeData get theme => Theme.of(this);

  /// Check if dark mode theme is enable
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// similar to [MediaQuery.of(context).viewPadding]
  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).viewPadding;

  double get paddingTop => mediaQueryPadding.top;

  double get paddingBottom => mediaQueryPadding.bottom;

  /// similar to [MediaQuery.of(context).devicePixelRatio]
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  double dialogInsideWidth({
    double contentPadding = AppSize.horizontalSpacing,
  }) {
    return width - 40 * 2 - 2 * contentPadding;
  }

  double get bottomSpacing => paddingBottom > 0 ? paddingBottom : 10;

  TextStyle get bodySmall => theme.textTheme.bodySmall!;

  TextStyle get bodyMedium => theme.textTheme.bodyMedium!;

  TextStyle get bodyLarge => theme.textTheme.bodyLarge!;

  TextStyle get labelSmall => theme.textTheme.labelSmall!;

  TextStyle get labelMedium => theme.textTheme.labelMedium!;

  TextStyle get labelLarge => theme.textTheme.labelLarge!;

  TextStyle get titleSmall => theme.textTheme.titleSmall!;

  TextStyle get titleMedium => theme.textTheme.titleMedium!;

  TextStyle get titleLarge => theme.textTheme.titleLarge!;

  TextStyle get headlineSmall => theme.textTheme.headlineSmall!;

  TextStyle get displayLarge => theme.textTheme.displayLarge!;

  TextStyle get displayMedium => theme.textTheme.displayMedium!;

  TextStyle get displaySmall => theme.textTheme.displaySmall!;

  TextStyle get headlineLarge => theme.textTheme.headlineLarge!;
  
  TextStyle get headlineMedium => theme.textTheme.headlineMedium!;

  DefaultThemeConfig get themeConfig =>
      read<AppBloc>().state.themeSheet.themeConfig;
}
