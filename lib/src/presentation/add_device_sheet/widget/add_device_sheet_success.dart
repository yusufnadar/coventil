import 'package:coventil/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';

class AddDeviceSuccess extends StatelessWidget {
  const AddDeviceSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(Assets.icons.successCircle,height: 40.h),
            SizedBox(height: 8.h),
            Text(
              'Bağlantı başarıyla kuruldu.',
              style: AppStyles.regular(color: AppColors.darkGray),
            )
          ],
        ),
      ),
    );
  }
}
