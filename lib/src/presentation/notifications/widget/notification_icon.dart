import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../gen/assets.gen.dart';

class NotificationIcon extends StatelessWidget {
  final String notificationType;

  const NotificationIcon({super.key, required this.notificationType});

  @override
  Widget build(BuildContext context) {
    switch (notificationType) {
      case 'DeviceBatteryBelow20':
        return SvgPicture.asset(Assets.icons.notification.camera,height: 32.h);
      case 'DeviceCouldNotBeFoundOnCurrentLocation':
        return SvgPicture.asset(Assets.icons.notification.location,height: 32.h);
      case 'DeviceCouldNotBeStartedByTask':
        return SvgPicture.asset(Assets.icons.notification.warning,height: 32.h);
      case 'DeviceStartStopNotWorking':
        return SvgPicture.asset(Assets.icons.notification.notification,height: 32.h);
      default:
        return SvgPicture.asset(Assets.icons.notification.camera,height: 32.h);
    }
  }
}
