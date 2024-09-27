import 'package:coventil/src/presentation/device_detail/model/device_detail_model.dart';
import 'package:coventil/src/presentation/device_detail/view_model/device_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../common/widgets/custom_switch.dart';
import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/enums/device_status.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';

class MainDeviceDetailConnectedSubDevices extends StatelessWidget {
  final List<ConnectedSubDeviceList>? subDevices;

  const MainDeviceDetailConnectedSubDevices({super.key, this.subDevices});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subDevices!.length,
      itemBuilder: (context, index) {
        final item = subDevices![index];
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [
              SvgPicture.asset(Assets.icons.connectedValve, height: 32.h),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? '',
                    style: AppStyles.semiBold(fontSize: 16, color: AppColors.textDark2),
                  ),
                  Text(
                    item.valveNameList!.map((e) => e).join(', '),
                    style: AppStyles.regular(fontSize: 10, color: AppColors.gray3),
                  ),
                ],
              ),
              const Spacer(),
              CustomSwitch(
                activeColor: AppColors.primaryGreen,
                deviceStatus: item.status == DeviceStatus.Passive.name ? false : true,
                onChanged: (value) {
                  context.read<DeviceDetailViewModel>().updateMainSubDevicesStatus(
                        isOpen: value,
                        subDevice: item,
                      );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
