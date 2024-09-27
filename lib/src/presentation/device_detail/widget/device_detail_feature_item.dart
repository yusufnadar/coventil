import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';

class DeviceDetailFeatureItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;

  const DeviceDetailFeatureItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          SvgPicture.asset(icon, height: 32.h),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.semiBold(color: AppColors.textDark2),
              ),
              SizedBox(height: 3.h),
              Text(
                subtitle,
                style: AppStyles.regular(fontSize: 10, color: AppColors.gray3),
              ),
            ],
          )
        ],
      ),
    );
  }
}
