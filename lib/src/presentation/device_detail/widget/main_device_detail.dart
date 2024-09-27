import 'package:coventil/src/core/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/constants/color/app_colors.dart';
import '../../../core/helper/mixin/asset_mixin.dart';
import '../view_model/device_detail_view_model.dart';
import 'device_detail_feature_item.dart';
import 'main_device_detail_connected_sub_devices.dart';
import 'main_device_detail_switch.dart';

class MainDeviceDetail extends StatelessWidget with AssetMixin {
  const MainDeviceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceDetailViewModel>(
      builder: (BuildContext context, model, Widget? child) {
        if (model.deviceDetail != null && model.marker != null) {
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
                  ],
                ),
                SizedBox(height: 24.h),
                const MainDeviceDetailSwitch(),
                buildDivider(context),
                MainDeviceDetailConnectedSubDevices(
                  subDevices: model.deviceDetail!.connectedSubDeviceList!,
                ),
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
