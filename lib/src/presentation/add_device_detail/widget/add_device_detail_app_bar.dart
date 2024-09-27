import 'package:coventil/src/common/widgets/custom_button.dart';
import 'package:coventil/src/core/constants/route/app_routes.dart';
import 'package:coventil/src/core/extensions/context.dart';
import 'package:coventil/src/presentation/add_device_detail/view_model/add_device_detail_view_model.dart';
import 'package:coventil/src/presentation/add_device_sheet/enum/selected_device_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';
import '../../../core/services/locator/locator_service.dart';
import '../../../core/services/route/route_service.dart';

class AddDeviceDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final SelectedDeviceEnum type;

  const AddDeviceDetailAppBar({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddDeviceDetailViewModel>();
    return AppBar(
      leading: buildLeading(model),
      leadingWidth: 52.w,
      title: buildSteps(model),
      actions: [
        buildCloseButton(context: context),
      ],
    );
  }

  GestureDetector buildCloseButton({required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          enableDrag: false,
          isDismissible: false,
          builder: (context) {
            return Column(
              children: [
                buildWarningTitle(),
                Container(height: 1.h, width: context.width, color: AppColors.gray4),
                Padding(
                  padding: EdgeInsets.only(top: 28.h, bottom: 24.h),
                  child: SvgPicture.asset(Assets.icons.warning, height: 120.h),
                ),
                ...[
                  buildAreYouSure(),
                  buildAreYouSureDescription(),
                  buildActions(),
                ],
              ],
            );
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 20.w),
        child: SvgPicture.asset(Assets.icons.close, height: 32.h),
      ),
    );
  }

  Padding buildWarningTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Center(
        child: Text('Uyarı', style: AppStyles.semiBold(fontSize: 16)),
      ),
    );
  }

  Padding buildAreYouSureDescription() {
    return Padding(
      padding: EdgeInsets.only(right: 18.w, left: 18.w, top: 8.h, bottom: 24.h),
      child: Text(
        'Cihaz ekleme işleminiz iptal edilecektir. Bu işleme devam etmek istiyor musunuz?',
        style: AppStyles.regular(color: AppColors.textDark),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding buildAreYouSure() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Text(
        'Çıkmak istediğinize emin misiniz?',
        style: AppStyles.bold(fontSize: 24),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding buildActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              onTap: () {
                getIt<RouteService>().goRemoveUntil(path: AppRoutes.home);
              },
              title: 'Devam et',
              height: 48.h,
              backgroundColor: AppColors.white,
              textColor: AppColors.primaryGreen,
              borderColor: AppColors.primaryGreen,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: CustomButton(
              onTap: getIt<RouteService>().pop,
              title: 'Vazgeç',
              height: 48.h,
            ),
          ),
        ],
      ),
    );
  }

  Column buildSteps(AddDeviceDetailViewModel model) {
    return Column(
      children: [
        Text(
          'Cihaz Ekle',
          style: AppStyles.semiBold(fontSize: 16, color: AppColors.black),
        ),
        if (type == SelectedDeviceEnum.subDevice)
          Text(
            'Adım ${model.currentIndex + 1}/2',
            style: AppStyles.regular(fontSize: 12, color: AppColors.darkGray),
          ),
      ],
    );
  }

  Widget buildLeading(AddDeviceDetailViewModel model) {
    return model.currentIndex == 1
        ? GestureDetector(
            onTap: () {
              model.changeCurrentIndex(index: 0);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: SvgPicture.asset(Assets.icons.arrowBack),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
