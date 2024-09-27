import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

mixin ToastMessage {
  void showToast({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.yellow,
      textColor: AppColors.white,
      fontSize: 14.sp,
    );
  }
}
