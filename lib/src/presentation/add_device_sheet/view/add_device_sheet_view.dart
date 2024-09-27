import 'package:coventil/gen/assets.gen.dart';
import 'package:coventil/src/common/widgets/custom_button.dart';
import 'package:coventil/src/core/extensions/context.dart';
import 'package:coventil/src/presentation/add_device_sheet/enum/selected_device_enum.dart';
import 'package:coventil/src/presentation/add_device_sheet/view_model/add_device_sheet_view_model.dart';
import 'package:coventil/src/presentation/add_device_sheet/widget/add_device_sheet_serial_number_input.dart';
import 'package:coventil/src/presentation/add_device_sheet/widget/add_device_sheet_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../common/model/value/value_model.dart';
import '../../../common/widgets/custom_drop_down.dart';
import '../../../core/constants/color/app_colors.dart';
import '../../../core/constants/text_styles/app_text_styles.dart';
import '../../add_device_detail/widget/device_input_title.dart';
import '../mixin/add_device_sheet_mixin.dart';
import '../widget/add_device_sheet_app_bar.dart';
import '../widget/add_device_sheet_loading.dart';

class AddDeviceSheetView extends StatefulWidget {
  const AddDeviceSheetView({super.key});

  @override
  State<AddDeviceSheetView> createState() => _AddDeviceSheetViewState();
}

class _AddDeviceSheetViewState extends State<AddDeviceSheetView> with AddDeviceSheetMixin {
  @override
  void initState() {
    super.initState();
    context.read<AddDeviceSheetViewModel>().getMainDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddDeviceSheetViewModel>(
      builder: (BuildContext context, model, Widget? child) {
        return SingleChildScrollView(
          padding: MediaQuery.of(context).viewInsets,
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AddDeviceAppBar(),
              Container(height: 1.h, width: context.width, color: AppColors.gray4),
              Padding(
                padding: EdgeInsets.only(bottom: 14.h, right: 20.w, left: 20.w, top: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (model.deviceType == SelectedDeviceEnum.subDevice) ...[
                      const DeviceInputTitle(text: 'Bağlı Olduğu Ana Cihaz'),
                      buildMainDeviceDropDown(model),
                      SizedBox(height: 12.h),
                    ],
                    if (model.deviceType != null) ...[
                      Text(
                        'Seri No',
                        style: AppStyles.regular(color: AppColors.textDark),
                      ),
                      SizedBox(height: 6.h),
                      AddDeviceSheetSerialNumberInput(
                        model: model,
                        controller: serialNumberController,
                        formKey: formKey,
                        errorText: model.errorText,
                      ),
                      if (model.isLoading) const AddDeviceLoading(),
                      if (model.isSuccess) const AddDeviceSuccess(),
                      buildGoOnButton(model),
                    ] else ...[
                      buildSelectDevices(model),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  SafeArea buildSelectDevices(model) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildDeviceOption(
            icon: Assets.icons.addMainDevice,
            text: 'Ana Cihaz Ekle',
            type: SelectedDeviceEnum.parentDevice,
            model: model,
          ),
          buildDeviceOption(
            icon: Assets.icons.addSubDevice,
            text: 'Alt Cihaz Ekle',
            type: SelectedDeviceEnum.subDevice,
            model: model,
          ),
        ],
      ),
    );
  }

  GestureDetector buildDeviceOption({
    required String icon,
    required String text,
    required SelectedDeviceEnum type,
    required AddDeviceSheetViewModel model,
  }) {
    return GestureDetector(
      onTap: () => model.chooseDeviceType(deviceType: type),
      child: Column(
        children: [
          SvgPicture.asset(icon, height: 48.h),
          SizedBox(height: 12.h),
          Text(text, style: AppStyles.regular())
        ],
      ),
    );
  }

  Padding buildGoOnButton(AddDeviceSheetViewModel model) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h, bottom: 10.h),
      child: CustomButton(
        onTap: () => model.controlSerialNumber(serialNumber: serialNumberController.text),
        height: 48.h,
        title: 'Devam et',
        backgroundColor: model.buttonColor,
      ),
    );
  }

  CustomDropDown<int> buildMainDeviceDropDown(AddDeviceSheetViewModel model) {
    return CustomDropDown<int>(
      value: model.mainDeviceId,
      hintText: 'Bağlı Olduğu Ana Cihaz Seçiniz',
      items: model.mainDevices.map((ValueModel value) {
        return DropdownMenuItem<int>(
          value: value.id,
          child: Text(
            value.value ?? '',
            style: AppStyles.semiBold(fontSize: 16, color: AppColors.black2),
          ),
        );
      }).toList(),
      onChanged: (value) => model.changeMainDevice(value, serialNumberController.text),
    );
  }
}
