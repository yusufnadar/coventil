import 'package:coventil/src/presentation/device_detail/model/device_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../common/widgets/custom_switch.dart';
import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/enums/device_status.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';
import '../view_model/device_detail_view_model.dart';

class DeviceDetailConnectedValves extends StatelessWidget {
  final List<ValveModel>? valves;

  const DeviceDetailConnectedValves({super.key, this.valves});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: valves?.length,
      itemBuilder: (context, index) {
        final item = valves![index];
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [
              SvgPicture.asset(Assets.icons.connectedValve, height: 32.h),
              SizedBox(width: 8.w),
              Text(
                item.valveName ?? '',
                style: AppStyles.semiBold(fontSize: 16, color: AppColors.textDark2),
              ),
              const Spacer(),
              CustomSwitch(
                activeColor: AppColors.primaryGreen,
                deviceStatus: item.valveStatus == DeviceStatus.Passive.name ? false : true,
                onChanged: (value) {
                  context.read<DeviceDetailViewModel>().updateSubDeviceValve(
                    isOpen: value,
                    valveId: item.id,
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
