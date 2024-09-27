import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color/app_colors.dart';

class AppStyles {
  static TextStyle light({
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize?.sp ?? 14.sp,
      fontWeight: FontWeight.w300,
      color: color ?? AppColors.primaryDark,
      decoration: decoration,
      height: height,
      decorationColor: AppColors.white,
    );
  }

  static TextStyle regular({
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize?.sp ?? 14.sp,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.primaryDark,
      decoration: decoration,
      height: height,
    );
  }

  static TextStyle medium({
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize?.sp ?? 14.sp,
      fontWeight: FontWeight.w500,
      color: color ?? AppColors.primaryDark,
      height: height,
      decoration: decoration,
      decorationColor: AppColors.white,
    );
  }

  static TextStyle semiBold({
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize?.sp ?? 14.sp,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors.primaryDark,
      decoration: decoration,
      height: height,
      decorationColor: AppColors.white,
    );
  }

  static TextStyle bold({
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize?.sp ?? 14.sp,
      fontWeight: FontWeight.w700,
      color: color ?? AppColors.primaryDark,
      height: height,
      decoration: decoration,
      decorationColor: AppColors.white,
    );
  }
}
