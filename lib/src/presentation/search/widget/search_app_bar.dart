import 'package:coventil/src/core/services/locator/locator_service.dart';
import 'package:coventil/src/core/services/route/route_service.dart';
import 'package:coventil/src/presentation/search/mixin/search_mixin.dart';
import 'package:coventil/src/presentation/search/view_model/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({super.key});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> with SearchMixin {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<SearchViewModel>();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.16),
            offset: const Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          buildBackButton(context),
          SizedBox(width: 8.w),
          buildInput(model),
        ],
      ),
    );
  }

  GestureDetector buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getIt<RouteService>().pop();
        deviceController.clear();
      },
      child: SvgPicture.asset(Assets.icons.dropArrowLeft, height: 20.h),
    );
  }

  Expanded buildInput(SearchViewModel model) {
    return Expanded(
      child: TextFormField(
        cursorColor: AppColors.primaryBlue,
        controller: deviceController,
        autofocus: true,
        onChanged: onChange,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
          errorBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            // ignore: prefer_const_constructors
            borderSide: BorderSide(color: AppColors.primaryBlue),
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 24.h),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 16.w, left: 8.w),
            child: SvgPicture.asset(Assets.icons.search),
          ),
          suffixIcon: deviceController.text != ''
              ? GestureDetector(
                  onTap: () {
                    deviceController.clear();
                    model.clear();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: SvgPicture.asset(Assets.icons.closeCircle),
                  ),
                )
              : const SizedBox.shrink(),
          suffixIconConstraints: BoxConstraints(maxHeight: 16.h),
          hintText: 'Cihaz Ara',
          hintStyle: AppStyles.regular(fontSize: 16, color: AppColors.lightGray3),
        ),
      ),
    );
  }
}
