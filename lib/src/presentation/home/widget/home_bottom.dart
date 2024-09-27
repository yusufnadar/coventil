import 'package:cached_network_image/cached_network_image.dart';
import 'package:coventil/src/presentation/home/model/weather_model.dart';
import 'package:coventil/src/presentation/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';

class HomeBottom extends StatelessWidget implements PreferredSizeWidget {
  const HomeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (BuildContext context, model, Widget? child) {
        if (model.weathers.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  buildDegreeAndLocation(model.currentDegree ?? 0),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(left: 20.w),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          model.weathers.length,
                          (index) => buildDailyWeather(index, model.weathers[index]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Container buildDailyWeather(int index, Forecast weather) {
    return Container(
      margin: EdgeInsets.only(right: 8.w, bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.white,
        border: Border.all(color: index == 0 ? AppColors.primaryBlue : AppColors.transparent),
      ),
      child: Row(
        children: [
          CachedNetworkImage(imageUrl: 'https:${weather.condition?.icon}', height: 30.h),
          SizedBox(width: 9.w),
          Column(
            children: [
              Text(
                weather.day!,
                style: AppStyles.regular(color: AppColors.textDark),
              ),
              Row(
                children: [
                  Text(
                    '${weather.lowTemp}°',
                    style: AppStyles.regular(color: AppColors.black2),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '${weather.highTemp}°',
                    style: AppStyles.regular(color: AppColors.textDark),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding buildDegreeAndLocation(int degree) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h, left: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                degree.toString(),
                style: AppStyles.bold(fontSize: 20, color: AppColors.primaryNavy),
              ),
              SizedBox(width: 7.w),
              Text(
                '°C',
                style: AppStyles.regular(fontSize: 12, color: AppColors.lightBlue),
              ),
            ],
          ),
          Text(
            'İstanbul',
            style: AppStyles.regular(fontSize: 10, color: AppColors.primaryNavy),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
