import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/color/app_colors.dart';

class CustomSwitch extends StatelessWidget {
  final Color activeColor;
  final bool? deviceStatus;
  final ValueChanged<bool>? onChanged;

  const CustomSwitch({
    super.key,
    required this.activeColor,
    this.onChanged,
    this.deviceStatus,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch(
          value: deviceStatus!,
          activeTrackColor: AppColors.green2,
          activeColor: AppColors.white,
          trackOutlineWidth: MaterialStateProperty.resolveWith<double?>(
            (Set<MaterialState> states) => 0,
          ),
          trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) => Colors.transparent,
          ),
          thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
            (Set<MaterialState> states) => const Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
          inactiveThumbColor: AppColors.white,
          inactiveTrackColor: AppColors.gray,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
