// ignore_for_file: use_build_context_synchronously

import 'package:coventil/src/presentation/notifications/model/notification_model.dart';
import 'package:coventil/src/presentation/notifications/view_model/notifications_view_model.dart';
import 'package:coventil/src/presentation/notifications/widget/notification_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';
import '../../device_detail/view/device_detail_view.dart';

class UnreadNotificationBox extends StatelessWidget {
  final NotificationModel item;
  final int index;

  const UnreadNotificationBox({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context
            .read<NotificationsViewModel>()
            .readNotification(index: index, notificationId: item.notificationId!);
        DeviceDetailView.showModalSheet(
          context: context,
          deviceName: item.deviceName,
          deviceType: item.deviceType,
          deviceId: item.deviceId,
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 4.w, top: 20.h),
              child: CircleAvatar(radius: 3.h, backgroundColor: AppColors.red),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 20.w),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.lightRed2,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: NotificationIcon(notificationType: item.notificationType!),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTitle(),
                          buildDescription(),
                          buildDate(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text buildDate() {
    return Text(
      DateFormat.Hm().format(item.createdAt!).toString(),
      style: AppStyles.light(fontSize: 11, color: AppColors.lightGray),
    );
  }

  Padding buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Text(
        'Lorem ipsum dolor sit amet consectetur. Ipsum ut mi dui tincidunt et tortor tempus. Lorem ut vitae nunc amet ipsum rhoncus sed tristique.',
        style: AppStyles.regular(fontSize: 12, color: AppColors.darkGray),
      ),
    );
  }

  Row buildTitle() {
    return Row(
      children: [
        Expanded(
          child: Text(
            item.title ?? '',
            style: AppStyles.semiBold(),
          ),
        ),
        SizedBox(width: 4.w),
        SvgPicture.asset(Assets.icons.arrowRight, height: 16.h),
      ],
    );
  }
}
