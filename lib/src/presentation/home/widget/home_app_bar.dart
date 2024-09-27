import 'package:coventil/src/common/view_model/user_view_model.dart';
import 'package:coventil/src/core/constants/local/app_locals.dart';
import 'package:coventil/src/core/constants/route/app_routes.dart';
import 'package:coventil/src/core/extensions/context.dart';
import 'package:coventil/src/core/services/local/local_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';
import '../../../core/services/locator/locator_service.dart';
import '../../../core/services/route/route_service.dart';
import 'home_bottom.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: buildAppLogo(),
      centerTitle: false,
      titleSpacing: 0,
      actions: [
        buildNotificationsIcon(),
        buildCircleImage(context),
      ],
      bottom: const HomeBottom(),
    );
  }

  Padding buildCircleImage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w, left: 16.w),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildAccountTitle(),
                    Container(
                      height: 1.h,
                      width: context.width,
                      color: AppColors.gray4,
                      margin: EdgeInsets.only(bottom: 16.h),
                    ),
                    buildAccountInformations(),
                    Container(
                      height: 1.h,
                      width: context.width,
                      color: AppColors.gray6,
                      margin: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    buildLogout(),
                    SizedBox(height: 22.h),
                  ],
                ),
              );
            },
          );
        },
        child: CircleAvatar(
          radius: 16.h,
          backgroundImage: AssetImage(Assets.images.noProfile.path),
        ),
      ),
    );
  }

  Padding buildLogout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GestureDetector(
        onTap: getIt<UserViewModel>().logout,
        child: Container(
          color: AppColors.white,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 12,
                      spreadRadius: 0,
                      color: AppColors.black.withOpacity(0.09),
                    ),
                  ],
                ),
                child: SvgPicture.asset(Assets.icons.logoutCircle, height: 40.w),
              ),
              SizedBox(width: 12.w),
              Text('Çıkış Yap', style: AppStyles.semiBold(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildAccountInformations() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.h,
            backgroundImage: AssetImage(Assets.images.noProfile.path),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getIt<LocalService>().read(AppLocals.name),
                style: AppStyles.semiBold(fontSize: 16),
              ),
              Text(
                getIt<LocalService>().read(AppLocals.email),
                style: AppStyles.semiBold(fontSize: 12, color: AppColors.lightGray),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding buildAccountTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Opacity(
            opacity: 0,
            child: SvgPicture.asset(Assets.icons.close, width: 32.w),
          ),
          Text(
            'Hesap',
            style: AppStyles.semiBold(fontSize: 16),
          ),
          GestureDetector(
            onTap: getIt<RouteService>().pop,
            child: SvgPicture.asset(Assets.icons.close, width: 32.w),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationsIcon() {
    return ChangeNotifierProvider.value(
      value: getIt<UserViewModel>(),
      child: Consumer<UserViewModel>(
        builder: (BuildContext context, model, Widget? child) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  getIt<RouteService>().go(path: AppRoutes.notifications);
                },
                child: SvgPicture.asset(Assets.icons.notificationSvg, height: 24.h),
              ),
              if (model.unReadNotification == true)
                Positioned(
                  top: 0,
                  right: 3.w,
                  child: CircleAvatar(
                    radius: 4.h,
                    backgroundColor: AppColors.red,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Padding buildAppLogo() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: SvgPicture.asset(Assets.icons.logo, height: 24.h),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120.h);
}
