import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:coventil/src/core/constants/enums/device_status.dart';
import 'package:coventil/src/core/extensions/context.dart';
import 'package:coventil/src/presentation/add_device_sheet/enum/selected_device_enum.dart';
import 'package:coventil/src/presentation/home/model/device_model.dart';
import 'package:coventil/src/presentation/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';
import '../../device_detail/view/device_detail_view.dart';

class CustomWindow extends StatefulWidget {
  final DeviceModel device;
  final ValueChanged<bool> onChanged;

  const CustomWindow({super.key, required this.device, required this.onChanged});

  @override
  State<CustomWindow> createState() => _CustomWindowState();
}

class _CustomWindowState extends State<CustomWindow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              buildTitle(),
              const Spacer(),
              buildDetail(context),
            ],
          ),
          buildValveCount(),
          if (widget.device.deviceType!.toUpperCase() ==
              SelectedDeviceEnum.parentDevice.name.toUpperCase())
            buildMoistureAndBattery(),
          buildDivider(context),
          buildDeviceSwitch(context),
        ],
      ),
    );
  }

  buildDeviceSwitch(BuildContext context) {
    return Consumer<HomeViewModel>(
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
                    color: AppColors.black.withOpacity(0.08),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                widget.device.deviceStatus == DeviceStatus.Passive.name
                    ? Assets.icons.deviceSwitchClose
                    : Assets.icons.deviceSwitchOpen,
                height: 40.h,
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.device.deviceStatus == DeviceStatus.Passive.name
                      ? 'Cihazı Aç'
                      : 'Cihazı Kapat',
                  style: AppStyles.semiBold(fontSize: 16),
                ),
                SizedBox(height: 2.h),
                Text(
                  widget.device.deviceStatus == DeviceStatus.Passive.name ? 'Kapalı' : 'Açık',
                  style: AppStyles.semiBold(fontSize: 12, color: AppColors.lightGray),
                ),
              ],
            ),
            const Spacer(),
            Switch(
              value: widget.device.deviceStatus == DeviceStatus.Passive.name ? false : true,
              activeTrackColor: AppColors.green2,
              activeColor: AppColors.white,
              trackOutlineWidth: MaterialStateProperty.resolveWith<double?>(
                (Set<MaterialState> states) => 0,
              ),
              trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) => Colors.transparent,
              ),
              thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                (Set<MaterialState> states) => const Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
              inactiveThumbColor: AppColors.white,
              inactiveTrackColor: AppColors.gray,
              onChanged: widget.onChanged,
            ),
          ],
        );
      },
    );
  }

  Container buildDivider(BuildContext context) {
    return Container(
      height: 1.h,
      width: context.width,
      color: AppColors.lightGray2,
      margin: EdgeInsets.only(bottom: 16.h),
    );
  }

  Padding buildMoistureAndBattery() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.icons.moisture2,
            height: 24.h,
          ),
          SizedBox(width: 8.w),
          Text(
            '%${widget.device.moisturePercentage} Nem',
            style: AppStyles.semiBold(color: AppColors.textDark2),
          ),
          const Spacer(),
          SvgPicture.asset(
            Assets.icons.battery2,
            height: 24.h,
          ),
          SizedBox(width: 8.w),
          Text(
            '%${widget.device.batteryPercentage} Batarya',
            style: AppStyles.semiBold(color: AppColors.textDark2),
          ),
        ],
      ),
    );
  }

  Padding buildValveCount() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Text(
        widget.device.deviceType!.toUpperCase() ==
                SelectedDeviceEnum.parentDevice.name.toUpperCase()
            ? 'Bağlı Alt Cihaz Sayısı: ${widget.device.connectedSubDeviceCount}'
            : 'Bağlı Vana Sayısı: ${widget.device.connectedValveCount}',
        style: AppStyles.regular(fontSize: 12, color: AppColors.gray3),
      ),
    );
  }

  GestureDetector buildDetail(BuildContext context) {
    final model = context.read<HomeViewModel>();
    return GestureDetector(
      onTap: () async {
        await DeviceDetailView.showModalSheet(
          context: context,
          deviceName:  widget.device.deviceName,
          deviceType:  widget.device.deviceType,
          deviceId:  widget.device.deviceId,
        );
        await model.getDeviceDetail(deviceId: widget.device.deviceId!);
      },
      child: Container(
        color: AppColors.transparent,
        child: Row(
          children: [
            Text(
              'Detay',
              style: AppStyles.semiBold(fontSize: 12, color: AppColors.primaryNavy),
            ),
            SizedBox(width: 4.w),
            SvgPicture.asset(Assets.icons.arrowRight, height: 16.h),
          ],
        ),
      ),
    );
  }

  Text buildTitle() {
    return Text(
      widget.device.deviceName ?? '',
      style: AppStyles.semiBold(fontSize: 16),
    );
  }
}
