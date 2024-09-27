import 'package:coventil/src/core/extensions/context.dart';
import 'package:coventil/src/presentation/device_detail/widget/device_detail_connected_valves.dart';
import 'package:coventil/src/presentation/device_detail/widget/sub_device_detail_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/constants/color/app_colors.dart';
import '../view_model/device_detail_view_model.dart';
import 'device_detail_feature_item.dart';
import 'device_detail_tasks.dart';

class SubDeviceDetail extends StatelessWidget {
  const SubDeviceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceDetailViewModel>(
      builder: (BuildContext context, model, Widget? child) {
        if (model.deviceDetail != null && model.marker != null) {
          print(model.marker);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    height: 150.h,
                    width: 317.w,
                    margin: EdgeInsets.only(top: 12.h, bottom: 24.h),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationButtonEnabled: false,
                      markers: {model.marker!},
                      initialCameraPosition: CameraPosition(
                        zoom: 14,
                        target: LatLng(
                          double.parse(model.deviceDetail!.latitude!),
                          double.parse(model.deviceDetail!.longitude!),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    DeviceDetailFeatureItem(
                      title: '${model.deviceDetail?.city}, ${model.deviceDetail?.country}',
                      subtitle: 'Bulunduğu Konum',
                      icon: Assets.icons.location,
                    ),
                    DeviceDetailFeatureItem(
                      title: '%${model.deviceDetail?.batteryPercentage}',
                      subtitle: 'Batarya',
                      icon: Assets.icons.battery,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 32.h),
                  child: Row(
                    children: [
                      DeviceDetailFeatureItem(
                        title: '%${model.deviceDetail?.moisturePercentage}',
                        subtitle: 'Nem',
                        icon: Assets.icons.moisture,
                      ),
                    ],
                  ),
                ),
                const SubDeviceDetailSwitch(),
                buildDivider(context),
                DeviceDetailConnectedValves(valves: model.deviceDetail!.connectedValveList!),
                DeviceDetailTasks(tasks:model.deviceDetail!.connectedTaskList!),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Container buildDivider(BuildContext context) {
    return Container(
      height: 1.h,
      width: context.width,
      color: AppColors.lightGray2,
      margin: EdgeInsets.symmetric(vertical: 16.h),
    );
  }
}
