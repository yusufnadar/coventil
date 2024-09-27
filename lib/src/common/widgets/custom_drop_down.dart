import 'package:coventil/src/core/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';
import '../../core/constants/color/app_colors.dart';
import '../../core/constants/text_styles/app_text_styles.dart';

class CustomDropDown<T> extends StatelessWidget {
  final T? value;
  final String hintText;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;

  const CustomDropDown({
    super.key,
    required this.value,
    required this.hintText,
    this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.lightGray2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          items: items,
          focusColor: AppColors.red,
          isDense: true,
          hint: Text(
            hintText,
            style: AppStyles.regular(fontSize: 16, color: AppColors.lightGray),
          ),
          dropdownColor: AppColors.white,
          onChanged: onChanged,
          icon: SvgPicture.asset(Assets.icons.downArrow, height: 24.h),
          value: value,
        ),
      ),
    );
  }
}
