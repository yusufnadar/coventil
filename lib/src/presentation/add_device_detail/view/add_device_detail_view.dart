import 'package:coventil/src/common/model/value/value_model.dart';
import 'package:coventil/src/common/widgets/custom_drop_down.dart';
import 'package:coventil/src/common/widgets/custom_input.dart';
import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:coventil/src/core/constants/text_styles/app_text_styles.dart';
import 'package:coventil/src/core/extensions/context.dart';
import 'package:coventil/src/presentation/add_device_detail/mixin/add_device_detail_mixin.dart';
import 'package:coventil/src/presentation/add_device_detail/view_model/add_device_detail_view_model.dart';
import 'package:coventil/src/presentation/add_device_detail/widget/device_input_title.dart';
import 'package:coventil/src/presentation/add_device_sheet/enum/selected_device_enum.dart';
import 'package:coventil/src/presentation/add_device_sheet/model/validate_main_device_model.dart';
import 'package:coventil/src/presentation/add_device_sheet/model/validate_sub_device_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widget/add_device_detail_app_bar.dart';
import '../widget/add_device_detail_go_on.dart';

class AddDeviceDetailView extends StatefulWidget {
  final SelectedDeviceEnum deviceType;
  final ValidateMainDeviceModel? mainDevice;
  final ValidateSubDeviceModel? subDevice;
  final String? mainDeviceSerialNumber;

  const AddDeviceDetailView({
    super.key,
    required this.deviceType,
    this.mainDevice,
    this.subDevice,
    this.mainDeviceSerialNumber,
  });

  @override
  State<AddDeviceDetailView> createState() => _AddDeviceDetailViewState();
}

class _AddDeviceDetailViewState extends State<AddDeviceDetailView> with AddDeviceDetailMixin {
  @override
  void initState() {
    super.initState();
    context.read<AddDeviceDetailViewModel>().init(deviceType: widget.deviceType);
  }

  @override
  Widget build(BuildContext context) {
    context.read<AddDeviceDetailViewModel>().init(deviceType: widget.deviceType);
    return Consumer<AddDeviceDetailViewModel>(
      builder: (BuildContext context, model, Widget? child) {
        return Scaffold(
          appBar: AddDeviceDetailAppBar(type: widget.deviceType),
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildDivider(context),
                        if (widget.deviceType == SelectedDeviceEnum.subDevice) ...[
                          if (model.currentIndex == 0)
                            ...buildDeviceDetail(model)
                          else
                            ...buildValves(model),
                        ] else
                          ...buildMainDevice(model),
                        Container(height: 100.h),
                      ],
                    ),
                  ),
                ),
                AddDeviceDetailGoOn(
                  deviceType: widget.deviceType,
                  mainDevice: widget.mainDevice,
                  subDevice: widget.subDevice,
                    mainDeviceSerialNumber:widget.mainDeviceSerialNumber,

                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> buildMainDevice(AddDeviceDetailViewModel model) {
    return [
      buildDeviceDetailTitle(title: 'Cihaz Detay'),
      buildDeviceDescription(
        description: 'Donanım kurulumu için lokasyon ve diğer detay bilgileri eksiksiz doldurunuz.',
      ),
      const DeviceInputTitle(text: 'Ana Cihaz Adı'),
      buildNameInput(model),
      const DeviceInputTitle(text: 'İl'),
      buildCityDropDown(model),
      const DeviceInputTitle(text: 'İlçe'),
      buildDistrictDropDown(model),
    ];
  }

  List<Widget> buildDeviceDetail(AddDeviceDetailViewModel model) {
    return [
      buildDeviceDetailTitle(title: 'Cihaz Detay'),
      buildDeviceDescription(
        description: 'Donanım kurulumu için lokasyon ve diğer detay bilgileri eksiksiz doldurunuz.',
      ),
      const DeviceInputTitle(text: 'Donanım Adı'),
      buildNameInput(model),
      const DeviceInputTitle(text: 'İl'),
      buildCityDropDown(model),
      const DeviceInputTitle(text: 'İlçe'),
      buildDistrictDropDown(model),
      const DeviceInputTitle(text: 'Şeflik'),
      buildConductingDeviceDropDown(model),
      const DeviceInputTitle(text: 'Park ve Bahçe'),
      buildParkDropDown(model),
    ];
  }

  List<Widget> buildValves(AddDeviceDetailViewModel model) {
    return [
      buildDeviceDetailTitle(title: 'Vana Detay'),
      buildDeviceDescription(
        description: 'Cihaz kurulumu için detay bilgileri eksiksiz doldurunuz.',
      ),
      const DeviceInputTitle(text: 'Vana Sayısı'),
      CustomDropDown(
        value: model.valveCount,
        hintText: 'Vana Sayısı',
        items: valves.map((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(
              value.toString(),
              style: AppStyles.semiBold(fontSize: 16, color: AppColors.black2),
            ),
          );
        }).toList(),
        onChanged: model.changeValveCount,
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: model.valveCount,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DeviceInputTitle(text: '${index + 1}. Vana Adı'),
              CustomInput(
                hintText: '${index + 1}. Vana Adı',
                controller: model.valveControllers[index],
                validator: (_) => null,
                onChanged: model.controlValveIsActive,
              ),
            ],
          );
        },
      ),
    ];
  }

  CustomDropDown<int> buildParkDropDown(AddDeviceDetailViewModel model) {
    return CustomDropDown(
      value: model.parkId,
      hintText: 'Park ve Bahçe Seçiniz',
      items: model.parks.map((ValueModel value) {
        return DropdownMenuItem<int>(
          value: value.id,
          child: Text(
            value.value ?? '',
            style: AppStyles.semiBold(fontSize: 16, color: AppColors.black2),
          ),
        );
      }).toList(),
      onChanged: model.changePark,
    );
  }

  CustomDropDown<int> buildConductingDeviceDropDown(AddDeviceDetailViewModel model) {
    return CustomDropDown(
      value: model.conductingId,
      hintText: 'Şeflik',
      items: model.conducting.map((ValueModel value) {
        return DropdownMenuItem<int>(
          value: value.id,
          child: Text(
            value.value ?? '',
            style: AppStyles.semiBold(fontSize: 16, color: AppColors.black2),
          ),
        );
      }).toList(),
      onChanged: model.changeConducting,
    );
  }

  CustomDropDown<int> buildDistrictDropDown(AddDeviceDetailViewModel model) {
    return CustomDropDown<int>(
      value: model.districtId,
      hintText: 'İlçe Seçiniz',
      items: model.districts.map((ValueModel item) {
        return DropdownMenuItem<int>(
          value: item.id,
          child: Text(
            item.value ?? '',
            style: AppStyles.semiBold(fontSize: 16, color: AppColors.black2),
          ),
        );
      }).toList(),
      onChanged: (value) => model.changeDistrict(value, widget.deviceType),
    );
  }

  CustomDropDown<int> buildCityDropDown(AddDeviceDetailViewModel model) {
    return CustomDropDown<int>(
      value: model.cityId,
      hintText: 'İl Seçiniz',
      items: model.cities.map((ValueModel item) {
        return DropdownMenuItem<int>(
          value: item.id,
          child: Text(
            item.value ?? '',
            style: AppStyles.semiBold(fontSize: 16, color: AppColors.black2),
          ),
        );
      }).toList(),
      onChanged: (value) => model.changeCity(value, widget.deviceType),
    );
  }

  CustomInput buildNameInput(AddDeviceDetailViewModel model) {
    return CustomInput(
      hintText: 'Donanım adı giriniz',
      controller: model.nameController,
      onChanged: (_) => widget.deviceType == SelectedDeviceEnum.parentDevice
          ? model.controlMainDeviceActive()
          : model.controlIsActive(),
      validator: (_) => null,
    );
  }

  Padding buildDeviceDescription({required String description}) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h, bottom: 24.h),
      child: Text(
        description,
        style: AppStyles.regular(color: AppColors.black3),
      ),
    );
  }

  Text buildDeviceDetailTitle({required String title}) {
    return Text(
      title,
      style: AppStyles.bold(fontSize: 24, color: AppColors.black),
    );
  }

  Container buildDivider(BuildContext context) {
    return Container(
      height: 1.h,
      width: context.width,
      color: AppColors.gray4,
      margin: EdgeInsets.only(top: 14.h, bottom: 24.h),
    );
  }
}
