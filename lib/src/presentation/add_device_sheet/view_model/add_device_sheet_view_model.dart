import 'package:coventil/src/common/model/value/value_model.dart';
import 'package:coventil/src/core/base/model/base_model.dart';
import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:coventil/src/core/constants/end_points/app_end_point.dart';
import 'package:coventil/src/core/constants/enums/http_type_enums.dart';
import 'package:coventil/src/core/services/network/network_service.dart';
import 'package:coventil/src/core/services/route/route_service.dart';
import 'package:coventil/src/presentation/add_device_sheet/enum/selected_device_enum.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/route/app_routes.dart';
import '../model/validate_main_device_model.dart';
import '../model/validate_sub_device_model.dart';

class AddDeviceSheetViewModel extends ChangeNotifier {
  AddDeviceSheetViewModel(this._networkService, this._routeService);

  final NetworkService _networkService;
  final RouteService _routeService;

  bool isActive = false;
  bool isLoading = false;
  bool isError = false;
  String errorText = '';
  bool isSuccess = false;
  String deviceTypeText = '';
  SelectedDeviceEnum? deviceType;
  int? mainDeviceId;
  String? mainDeviceSerialNumber;
  final mainDevices = <ValueModel>[];

  Color get buttonColor => isActive == true ? AppColors.primaryGreen : AppColors.lightGray2;

  void changeActive({required bool isActive}) {
    this.isActive = isActive;
    notifyListeners();
  }

  void changeMainDevice(int? mainDeviceId, String serialNumber) {
    this.mainDeviceId = mainDeviceId;
    mainDeviceSerialNumber =
        mainDevices.firstWhere((element) => element.id == mainDeviceId).serialNumber;
    notifyListeners();
    if (serialNumber.length == 19) {
      changeActive(isActive: true);
    }
  }

  Future<void> getMainDevices() async {
    final res = await _networkService.start(
      AppEndpoints.allDevices,
      httpTypes: HttpTypes.get,
    );
    res.fold((error) {
      print('getMainDevices $error');
    }, (result) {
      final res = ListBaseModelI.fromJson(result!, ValueModel());
      mainDevices.addAll(res.result!);
      notifyListeners();
    });
  }

  void chooseDeviceType({required SelectedDeviceEnum deviceType}) {
    this.deviceType = deviceType;
    if (deviceType == SelectedDeviceEnum.subDevice) {
      deviceTypeText = 'Alt';
    } else {
      deviceTypeText = 'Ana';
    }
    notifyListeners();
  }

  void changeSuccess({required bool isSuccess}) {
    this.isSuccess = isSuccess;
    notifyListeners();
  }

  void changeError({required bool isError}) {
    this.isError = isError;
    notifyListeners();
  }

  void changeLoading({required bool isLoading}) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void onChanged(String value, TextEditingController controller) {
    controller.text = value.toUpperCase();
    if (value.length == 19) {
      if (deviceType == SelectedDeviceEnum.parentDevice ||
          (deviceType == SelectedDeviceEnum.subDevice && mainDeviceId != null)) {
        changeActive(isActive: true);
      } else {
        changeActive(isActive: false);
      }
    } else {
      changeActive(isActive: false);
    }
  }

  Future<void> controlSerialNumber({required String serialNumber}) async {
    if (serialNumber.length != 19 || isLoading == true || isSuccess == true) return;
    changeError(isError: false);
    changeLoading(isLoading: true);
    if (deviceType == SelectedDeviceEnum.parentDevice) {
      final res = await _networkService.start(
        AppEndpoints.validateMainDevice,
        httpTypes: HttpTypes.get,
        queryParameters: {'SerialNumber': serialNumber.replaceAll('-', '')},
      );
      res.fold(
        (error) async {
          errorText = error.message ?? '';
          notifyListeners();
          changeError(isError: true);
          changeLoading(isLoading: false);
        },
        (result) async {
          changeLoading(isLoading: false);
          changeSuccess(isSuccess: true);
          final res = BaseModelI.fromJson(result!, ValidateMainDeviceModel());
          _routeService.pop();
          await _routeService.go(
            path: AppRoutes.addDeviceDetail,
            data: {'deviceType': deviceType, 'mainDevice': res.result},
          );
        },
      );
    } else if (deviceType == SelectedDeviceEnum.subDevice) {
      final res = await _networkService.start(
        AppEndpoints.validateSubDevice,
        httpTypes: HttpTypes.get,
        queryParameters: {
          'ParentDeviceSerialNumber': mainDeviceSerialNumber,
          'SubDeviceSerialNumber': serialNumber.replaceAll('-', ''),
        },
      );
      res.fold(
        (error) async {
          changeError(isError: true);
          changeLoading(isLoading: false);
        },
        (result) async {
          changeLoading(isLoading: false);
          changeSuccess(isSuccess: true);
          final res = BaseModelI.fromJson(result!, ValidateSubDeviceModel());
          _routeService.pop();
          await _routeService.go(
            path: AppRoutes.addDeviceDetail,
            data: {
              'deviceType': deviceType,
              'subDevice': res.result,
              'mainDeviceSerialNumber': mainDeviceSerialNumber,
            },
          );
        },
      );
    }
  }
}
