import 'package:coventil/src/core/constants/route/app_routes.dart';
import 'package:coventil/src/core/services/locator/locator_service.dart';
import 'package:coventil/src/core/services/route/route_service.dart';
import 'package:coventil/src/presentation/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeViewModel>();
    return Positioned(
      left: 20.w,
      right: 20.w,
      top: 16.h,
      child: Row(
        children: [
          model.fullScreenMap == true ? const Spacer() : buildSearchInput(),
          SizedBox(width: 8.w),
          buildEnlarge(model),
        ],
      ),
    );
  }

  Expanded buildSearchInput() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 13,
              spreadRadius: 0,
              color: AppColors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Consumer<HomeViewModel>(
          builder: (BuildContext context, HomeViewModel model, Widget? child) {
            return GestureDetector(
              onTap: () => getIt<RouteService>().go(path: AppRoutes.search),
              child: TextFormField(
                onTap: () {},
                autofocus: false,
                enabled: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 16.w),
                    child: SvgPicture.asset(Assets.icons.search, height: 24.h),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: const BorderSide(color: AppColors.primaryGreen),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                  prefixIconConstraints: BoxConstraints(maxHeight: 24.h),
                  hintText: 'Search Accounts & Cards',
                  hintStyle: AppStyles.regular(fontSize: 16, color: AppColors.lightGray3),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  GestureDetector buildEnlarge(HomeViewModel model) {
    return GestureDetector(
      onTap: model.changeFullScreenMap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 13,
              spreadRadius: 0,
              color: AppColors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: SvgPicture.asset(
            model.fullScreenMap == true ? Assets.icons.reduce : Assets.icons.enlarge,
            height: 40.h),
      ),
    );
  }
}
