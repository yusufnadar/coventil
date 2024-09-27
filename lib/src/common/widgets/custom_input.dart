import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../gen/assets.gen.dart';
import '../../core/constants/color/app_colors.dart';
import '../../core/constants/text_styles/app_text_styles.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? suffixIcon;
  final Function()? suffixOnTap;
  final bool? obscureText;
  final bool? error;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  const CustomInput({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.suffixIcon,
    this.suffixOnTap,
    this.obscureText,
    this.error,
    this.onChanged,
    this.inputFormatters, this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          obscureText: obscureText ?? false,
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          style: AppStyles.semiBold(fontSize: 16, color: AppColors.black2),
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: suffixOnTap,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: SvgPicture.asset(suffixIcon!),
                    ),
                  )
                : null,
            suffixIconConstraints: BoxConstraints(maxWidth: 44.w),
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
            isDense: true,
            hintStyle: AppStyles.regular(fontSize: 16, color: AppColors.lightGray),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.lightGray2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: error == true ? AppColors.red : AppColors.blue2,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.red),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.lightGray2),
            ),
            filled: true,
            fillColor: error == true ? AppColors.lightRed : AppColors.white,
          ),
        ),
        if (error == true) ...[
          SizedBox(height: 8.h),
          Row(
            children: [
              SvgPicture.asset(Assets.icons.inputError, height: 16.h),
              SizedBox(width: 4.w),
              Text(
                errorText ?? 'Empty',
                style: AppStyles.regular(fontSize: 12, color: AppColors.red),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
