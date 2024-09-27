import 'package:coventil/src/presentation/add_device_sheet/view_model/add_device_sheet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';
import '../../../core/services/locator/locator_service.dart';
import '../../../core/services/route/route_service.dart';

class AddDeviceAppBar extends StatelessWidget {
  const AddDeviceAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddDeviceSheetViewModel>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Opacity(
            opacity: 0,
            child: SvgPicture.asset(Assets.icons.close, width: 32.w),
          ),
          Text(
            '${model.deviceTypeText} Cihaz Ekle',
            style: AppStyles.semiBold(fontSize: 16),
          ),
          GestureDetector(
            onTap: model.isSuccess == true ? null : getIt<RouteService>().pop,
            child: SvgPicture.asset(Assets.icons.close, width: 32.w),
          ),
        ],
      ),
    );
  }
}
