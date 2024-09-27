import 'package:coventil/gen/assets.gen.dart';
import 'package:coventil/src/common/widgets/custom_button.dart';
import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:coventil/src/core/constants/route/app_routes.dart';
import 'package:coventil/src/core/constants/text_styles/app_text_styles.dart';
import 'package:coventil/src/core/services/locator/locator_service.dart';
import 'package:coventil/src/core/services/route/route_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessfulDeviceView extends StatelessWidget {
  final bool mainDevice;

  const SuccessfulDeviceView({super.key, required this.mainDevice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.icons.successCircle2, height: 120.h),
              if (mainDevice == true)
                Padding(
                  padding: EdgeInsets.only(top: 24.h, bottom: 8.h),
                  child: Text('Ana Cihaz başarıyla kuruldu!', style: AppStyles.bold(fontSize: 24)),
                )
              else
                Padding(
                  padding: EdgeInsets.only(top: 24.h, bottom: 8.h),
                  child: Text('Cihaz başarıyla kuruldu!', style: AppStyles.bold(fontSize: 24)),
                ),
              Text(
                'Donanım ve Cihaz ekleme işleminiz başarıyla kurulmuştur.',
                textAlign: TextAlign.center,
                style: AppStyles.regular(color: AppColors.textDark),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 39.w),
                child: CustomButton(
                  onTap: () {
                    getIt<RouteService>().goRemoveUntil(path: AppRoutes.home);
                  },
                  title: 'Tamam',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
