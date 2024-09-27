import 'package:coventil/src/presentation/add_device_detail/view_model/add_device_detail_view_model.dart';
import 'package:coventil/src/presentation/add_device_sheet/enum/selected_device_enum.dart';
import 'package:coventil/src/presentation/add_device_sheet/model/validate_main_device_model.dart';
import 'package:coventil/src/presentation/add_device_sheet/model/validate_sub_device_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../core/constants/color/app_colors.dart';

class AddDeviceDetailGoOn extends StatelessWidget {
  final SelectedDeviceEnum deviceType;
  final ValidateMainDeviceModel? mainDevice;
  final ValidateSubDeviceModel? subDevice;
  final String? mainDeviceSerialNumber;

  const AddDeviceDetailGoOn({
    super.key,
    required this.deviceType,
    this.mainDevice,
    this.subDevice,
    this.mainDeviceSerialNumber,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddDeviceDetailViewModel>();
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: CustomButton(
            onTap: () => model.onTap(
              type: deviceType,
              mainDevice: mainDevice,
              subDevice: subDevice,
              mainDeviceSerialNumber: mainDeviceSerialNumber,
            ),
            title: 'Devam et',
            backgroundColor: model.buttonColor(deviceType: deviceType),
          ),
        ),
      ),
    );
  }
}
