import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';
import '../../../core/services/locator/locator_service.dart';
import '../../../core/services/route/route_service.dart';

class DeviceDetailAppBar extends StatelessWidget {
  final String name;
  const DeviceDetailAppBar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Opacity(
                opacity: 0,
                child: SvgPicture.asset(Assets.icons.close, width: 32.w),
              ),
              Text(
                name,
                style: AppStyles.semiBold(fontSize: 16),
              ),
              GestureDetector(
                onTap: getIt<RouteService>().pop,
                child: SvgPicture.asset(Assets.icons.close, width: 32.w),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
