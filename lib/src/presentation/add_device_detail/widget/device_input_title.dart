import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';

class DeviceInputTitle extends StatelessWidget {
  final String text;
  const DeviceInputTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h,top: 16.h),
      child: Text(
        text,
        style: AppStyles.regular(color: AppColors.textDark),
      ),
    );
  }
}
