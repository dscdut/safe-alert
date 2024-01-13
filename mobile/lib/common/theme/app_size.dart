import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSize {
  static const double horizontalSpacing = 20;
  static const double cardRadius = 10;

  // App bar
  static const double appBarHeight = 60;
  static const double titleSpacing = 20;

  // Horizontal spacing
  static final SizedBox w5 = SizedBox(width: 5.w);
  static final SizedBox w10 = SizedBox(width: 10.w);
  static final SizedBox w15 = SizedBox(width: 15.w);
  static final SizedBox w20 = SizedBox(width: 20.w);
  static final SizedBox w25 = SizedBox(width: 25.w);
  static final SizedBox w30 = SizedBox(width: 30.w);

  // Vertical spacing
  static final SizedBox h5 = SizedBox(height: 5.h);
  static final SizedBox h10 = SizedBox(height: 10.h);
  static final SizedBox h15 = SizedBox(height: 15.h);
  static final SizedBox h20 = SizedBox(height: 20.h);
  static final SizedBox h25 = SizedBox(height: 25.h);
  static final SizedBox h30 = SizedBox(height: 30.h);
}
