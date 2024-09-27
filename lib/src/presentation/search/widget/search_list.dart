import 'package:coventil/src/core/extensions/context.dart';
import 'package:coventil/src/presentation/search/model/search_device_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';
import '../../device_detail/view/device_detail_view.dart';

class SearchList extends StatelessWidget {
  final List<SearchDeviceModel> devices;

  const SearchList({super.key, required this.devices});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: devices.length,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      itemBuilder: (context, index) {

        final item = devices[index];
        return GestureDetector(
          onTap: () {
            DeviceDetailView.showModalSheet(
              context: context,
              deviceName: item.value,
              deviceType: item.deviceType ?? 'ParentDevice',
              deviceId: item.id,
            );
          },
          child: Container(
            color: AppColors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      buildImage(item),
                      buildTitleAndSubtitle(item),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: AppColors.gray6,
                  width: context.width,
                  margin: EdgeInsets.symmetric(vertical: 16.h),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded buildTitleAndSubtitle(SearchDeviceModel item) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.value ?? '',
            style: AppStyles.semiBold(fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Text(
            item.serialNumber ?? '',
            style: AppStyles.semiBold(fontSize: 12, color: AppColors.lightGray),
          ),
        ],
      ),
    );
  }

  Container buildImage(SearchDeviceModel item) {
    return Container(
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 12,
            spreadRadius: 0,
            color: AppColors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: AppColors.white,
        radius: 20.w,
        child: Text(
          item.valueLetters ?? '',
          style: AppStyles.semiBold(
            fontSize: 18,
            color: AppColors.primaryNavy,
          ),
        ),
      ),
    );
  }
}
