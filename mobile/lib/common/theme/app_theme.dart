import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/common/theme/color_styles.dart';

class ThemeSheet {
  ThemeData themeData;
  DefaultThemeConfig themeConfig;

  ThemeSheet(this.themeConfig)
      : themeData = ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
          splashFactory: NoSplash.splashFactory,
          brightness: themeConfig.brightness,
          cardColor: themeConfig.cardColor,
          dialogBackgroundColor: themeConfig.dialogBackgroundColor,
          disabledColor: themeConfig.disabledColor,
          focusColor: themeConfig.focusColor,
          highlightColor: themeConfig.highlightColor,
          hintColor: themeConfig.hintColor,
          hoverColor: themeConfig.hoverColor,
          indicatorColor: themeConfig.indicatorColor,
          primaryColor: themeConfig.primaryColor,
          scaffoldBackgroundColor: themeConfig.scaffoldBackgroundColor,
          splashColor: Colors.transparent,
          unselectedWidgetColor: themeConfig.unselectedWidgetColor,
          dividerColor: themeConfig.dividerColor,
          fontFamily: 'Nunito',
          iconTheme: IconThemeData(
            color: themeConfig.textColor,
          ),
          textTheme: TextTheme(
            displayLarge: TextStyle(fontSize: 57.sp, color: themeConfig.textColor),
            displayMedium: TextStyle(fontSize: 45.sp, color: themeConfig.textColor),
            displaySmall: TextStyle(fontSize: 36.sp, color: themeConfig.textColor),
            headlineLarge: TextStyle(fontSize: 32.sp, color: themeConfig.textColor),
            headlineMedium: TextStyle(fontSize: 28.sp, color: themeConfig.textColor),
            headlineSmall: TextStyle(fontSize: 24.sp, color: themeConfig.textColor),
            titleLarge: TextStyle(fontSize: 22.sp, color: themeConfig.textColor),
            titleMedium: TextStyle(fontSize: 16.sp, color: themeConfig.textColor),
            titleSmall: TextStyle(fontSize: 14.sp, color: themeConfig.textColor),
            labelLarge: TextStyle(fontSize: 14.sp, color: themeConfig.textColor),
            labelMedium: TextStyle(fontSize: 12.sp, color: themeConfig.textColor),
            labelSmall: TextStyle(fontSize: 11.sp, color: themeConfig.textColor),
            bodyLarge: TextStyle(fontSize: 16.sp, color: themeConfig.textColor),
            bodyMedium: TextStyle(fontSize: 14.sp, color: themeConfig.textColor),
            bodySmall: TextStyle(fontSize: 12.sp, color: themeConfig.textColor),
          ),
          actionIconTheme: ActionIconThemeData(
            backButtonIconBuilder: (context) {
              return Icon(Icons.chevron_left, color: themeConfig.textColor);
            },
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: themeConfig.primaryColor,
          ),
        );
}

class DefaultThemeConfig {
  Brightness get brightness => Brightness.light;

  Color get cardColor => Colors.white;

  Color get dialogBackgroundColor => Colors.white;

  Color get primaryColor => const Color(0xFF1F57E7);

  Color get disabledColor => const Color(0xFFB5B3BC);

  Color get dividerColor => const Color(0xFFE5EAF2);

  Color get focusColor => primaryColor;

  Color get highlightColor => primaryColor;

  Color get hintColor => const Color(0xFF9999A3);

  Color get hoverColor => primaryColor;

  Color get indicatorColor => primaryColor;

  Color get errorColor => const Color(0xFFFF4445);

  Color get scaffoldBackgroundColor => Colors.white;

  Color get unselectedWidgetColor => disabledColor;

  Color get textColor => const Color(0xFF000118);

  Color get subTextColor => const Color(0xFF9999A3);

  Color get abcColor => Colors.blue;
}

class DarkThemeConfig extends DefaultThemeConfig {
  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get cardColor => const Color(0xFF656565);

  @override
  Color get dialogBackgroundColor => const Color(0xFF656565);

  @override
  Color get primaryColor => const Color(0xFF2A2A2A);

  @override
  Color get disabledColor => const Color(0xFFC5C5C5);

  @override
  Color get dividerColor => const Color(0xFF303239);

  @override
  Color get focusColor => const Color(0xFF2D2D2D);

  @override
  Color get highlightColor => const Color(0xFF656565);

  @override
  Color get hintColor => Colors.white.withOpacity(0.6);

  @override
  Color get hoverColor => primaryColor;

  @override
  Color get indicatorColor => primaryColor;

  @override
  Color get errorColor => const Color(0xFFCF6679);

  @override
  Color get scaffoldBackgroundColor => const Color(0xFF0F0E13);

  @override
  Color get subTextColor => Colors.white.withOpacity(0.4);

  @override
  Color get textColor => ColorStyles.darkTextColor;

  @override
  Color get unselectedWidgetColor => disabledColor;

  @override
  Color get abcColor => Colors.red;
}
