import 'package:coventil/src/presentation/device_detail/view_model/device_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../common/widgets/custom_switch.dart';
import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/enums/device_status.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';

class MainDeviceDetailSwitch extends StatelessWidget {
  const MainDeviceDetailSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceDetailViewModel>(
      builder: (BuildContext context, model, Widget? child) {
        return Row(
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
              child: SvgPicture.asset(
                model.deviceDetail?.deviceStatus == DeviceStatus.Passive.name
                    ? Assets.icons.deviceSwitchClose
                    : Assets.icons.deviceSwitchOpen,
                height: 40.h,
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.deviceDetail?.deviceName ?? '',
                  style: AppStyles.semiBold(color: AppColors.textDark2, fontSize: 16),
                ),
                SizedBox(height: 3.h),
                Text(
                  model.deviceDetail?.deviceStatus == DeviceStatus.Passive.name ? 'Kapalı' : 'Açık',
                  style: AppStyles.semiBold(fontSize: 12, color: AppColors.gray3),
                ),
              ],
            ),
            const Spacer(),
            CustomSwitch(
              activeColor: AppColors.primaryGreen,
              deviceStatus:
                  model.deviceDetail?.deviceStatus == DeviceStatus.Passive.name ? false : true,
              onChanged: (value) => model.updateMainDeviceStatus(
                isOpen: value,
                serialNumber: model.deviceDetail!.serialNumber ?? '',
              ),
            ),
          ],
        );
      },
    );
  }
}
