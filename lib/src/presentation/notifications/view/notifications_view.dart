import 'package:coventil/src/common/view_model/user_view_model.dart';
import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:coventil/src/core/constants/text_styles/app_text_styles.dart';
import 'package:coventil/src/core/extensions/context.dart';
import 'package:coventil/src/core/services/locator/locator_service.dart';
import 'package:coventil/src/core/services/route/route_service.dart';
import 'package:coventil/src/presentation/notifications/mixin/notifications_mixin.dart';
import 'package:coventil/src/presentation/notifications/view_model/notifications_view_model.dart';
import 'package:coventil/src/presentation/notifications/widget/notification_box.dart';
import 'package:coventil/src/presentation/notifications/widget/unread_notification_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> with NotificationsMixin {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_){
        getIt<UserViewModel>().getNotificationState();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hata Yönetimi', style: AppStyles.semiBold(fontSize: 16)),
          actions: [
            buildCloseButton(context: context),
          ],
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Container(
                height: 1.h,
                width: context.width,
                color: AppColors.gray4,
                margin: EdgeInsets.only(top: 10.h, bottom: 8.h),
              ),
              Consumer<NotificationsViewModel>(
                builder: (BuildContext context, model, Widget? child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.notifications.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = model.notifications[index];
                      if (item.notificationRead == false) {
                        return UnreadNotificationBox(item: item, index: index);
                      } else {
                        return NotificationBox(item: item);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildCloseButton({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: GestureDetector(
        onTap: () async {
          getIt<RouteService>().pop();
        },
        child: SvgPicture.asset(Assets.icons.close, height: 32.h),
      ),
    );
  }
}
