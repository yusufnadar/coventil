import 'package:coventil/src/core/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/color/app_colors.dart';
import '../../core/constants/text_styles/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.title,
    this.height,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 56.h,
        width: width ?? context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: borderColor ?? AppColors.transparent,width: 1.5),
          color: backgroundColor ?? AppColors.primaryGreen,
        ),
        child: Text(
          title,
          style: AppStyles.semiBold(fontSize: 16, color: textColor ?? AppColors.white),
        ),
      ),
    );
  }
}
