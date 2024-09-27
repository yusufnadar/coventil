import 'package:coventil/src/core/constants/app/app_constants.dart';
import 'package:flutter/material.dart';

import '../color/app_colors.dart';

class AppThemes {
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: AppConstants.fontFamily,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.white,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white,surfaceTintColor: Colors.transparent),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: AppColors.white,
        ),
      ),
    );
  }
}
