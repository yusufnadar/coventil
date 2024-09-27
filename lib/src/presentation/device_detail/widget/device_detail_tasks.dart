import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:coventil/src/core/constants/text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../gen/assets.gen.dart';
import '../model/device_detail_model.dart';

class DeviceDetailTasks extends StatelessWidget {
  final List<ConnectedTaskList> tasks;

  const DeviceDetailTasks({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 32.h, bottom: 12.h),
          child: Text(
            'Bağlı Görevler',
            style: AppStyles.semiBold(fontSize: 16, color: AppColors.textDark2),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final item = tasks[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.icons.mission, width: 32.w),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.taskName ?? '',
                        style: AppStyles.semiBold(color: AppColors.textDark2),
                      ),
                      Text(
                        item.taskSchedule ?? '',
                        style: AppStyles.regular(color: AppColors.gray3, fontSize: 10),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
