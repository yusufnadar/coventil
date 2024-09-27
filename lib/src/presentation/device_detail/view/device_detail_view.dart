import 'package:coventil/src/core/services/locator/locator_service.dart';
import 'package:coventil/src/core/services/network/network_service.dart';
import 'package:coventil/src/presentation/add_device_sheet/enum/selected_device_enum.dart';
import 'package:coventil/src/presentation/device_detail/view_model/device_detail_view_model.dart';
import 'package:coventil/src/presentation/device_detail/widget/sub_device_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../core/constants/color/app_colors.dart';
import '../widget/device_detail_app_bar.dart';
import '../widget/main_device_detail.dart';

class DeviceDetailView {
  static Future<dynamic> showModalSheet({
    required BuildContext context,
    String? deviceName,
    String? deviceType,
    int? deviceId,
  }) {
    return WoltModalSheet.show(
      context: context,
      pageListBuilder: (index) {
        return [
          SliverWoltModalSheetPage(
            hasTopBarLayer: true,
            hasSabGradient: true,
            surfaceTintColor: AppColors.transparent,
            backgroundColor: AppColors.white,
            forceMaxHeight: false,
            isTopBarLayerAlwaysVisible: true,
            leadingNavBarWidget: DeviceDetailAppBar(name: deviceName ?? ''),
            mainContentSlivers: [
              if (deviceType!.toUpperCase() == SelectedDeviceEnum.parentDevice.name.toUpperCase())
                ChangeNotifierProvider(
                  create: (BuildContext context) => DeviceDetailViewModel(getIt<NetworkService>())
                    ..getDeviceDetail(deviceId: deviceId),
                  child: const SliverToBoxAdapter(
                    child: MainDeviceDetail(),
                  ),
                )
              else
                ChangeNotifierProvider(
                  create: (BuildContext context) => DeviceDetailViewModel(getIt<NetworkService>())
                    ..getDeviceDetail(deviceId: deviceId),
                  child: const SliverToBoxAdapter(
                    child: SubDeviceDetail(),
                  ),
                ),
            ],
          ),
        ];
      },
    );
  }
}
