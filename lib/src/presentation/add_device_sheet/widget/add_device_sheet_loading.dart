import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';

class AddDeviceLoading extends StatelessWidget {
  const AddDeviceLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Center(
        child: Column(
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.gray5),
              strokeWidth: 2,
              backgroundColor: AppColors.black,
            ),
            SizedBox(height: 8.h),
            Text(
              'Bağlantı bekleniyor...',
              style: AppStyles.regular(color: AppColors.darkGray),
            )
          ],
        ),
      ),
    );
  }
}
