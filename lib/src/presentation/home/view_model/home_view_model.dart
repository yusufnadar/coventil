import 'dart:developer';

import 'package:coventil/src/core/base/model/base_model.dart';
import 'package:coventil/src/core/constants/end_points/app_end_point.dart';
import 'package:coventil/src/core/constants/enums/http_type_enums.dart';
import 'package:coventil/src/core/services/locator/locator_service.dart';
import 'package:coventil/src/core/services/network/network_service.dart';
import 'package:coventil/src/presentation/home/model/device_model.dart';
import 'package:coventil/src/presentation/home/model/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/constants/enums/device_status.dart';
import '../../../core/helper/mixin/asset_mixin.dart';
import '../../../packages/info_window/custom_info_window.dart';
import '../../add_device_sheet/enum/selected_device_enum.dart';
import '../../device_detail/model/device_detail_model.dart';
import '../widget/custom_window.dart';

class HomeViewModel extends ChangeNotifier with AssetMixin {
  bool fullScreenMap = false;
  bool hasFocus = false;
  final _networkService = getIt<NetworkService>();
  final devices = <DeviceModel>[];
  final markers = <Marker>[];
  int? selectedMarker;
  final weathers = <Forecast>[];
  int? currentDegree;
  bool changingDevice = false;
  bool unReadNotification = false;
  final customInfoWindowController = CustomInfoWindowController();

  void changeFullScreenMap() {
    fullScreenMap = !fullScreenMap;
    notifyListeners();
  }


  void changeHasFocus({required bool value}) {
    hasFocus = value;
    notifyListeners();
  }

  Future<void> getWeathers() async {
    try {
      final result = await Dio().get('https://coventil.pingpong.university/api/weather');
      final res = WeatherModel().fromJson(result.data);
      weathers.clear();
      weathers.addAll(res.forecast!);
      currentDegree = res.current;
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> getAllDevices() async {
    final res = await _networkService.start(
      AppEndpoints.getAllDevices,
      httpTypes: HttpTypes.get,
    );
    res.fold(
      (error) {
        print('error $error');
      },
      (result) {
        final res = ListBaseModelI.fromJson(result!, DeviceModel());
        devices.clear();
        devices.addAll(res.result!);
        notifyListeners();
        for (var item in devices) {
          buildMarkers(item);
        }
      },
    );
  }

  Future<void> buildMarkers(DeviceModel device) async {
    markers.add(
      Marker(
        icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset(
            device.deviceType!.toUpperCase() == SelectedDeviceEnum.parentDevice.name.toUpperCase()
                ? Assets.icons.mainValve.path
                : Assets.icons.valve.path,
            70.w.toInt(),
          ),
        ),
        markerId: MarkerId(device.deviceId.toString()),
        position: LatLng(double.parse(device.latitude!), double.parse(device.longitude!)),
        onTap: () async {
          showCustomInfo(device);
        },
      ),
    );
    notifyListeners();
  }

  void showCustomInfo(DeviceModel device) {
    customInfoWindowController.addInfoWindow!(
      CustomWindow(
        device: device,
        onChanged: (value) async {
          await updateDeviceStatus(isOpen: value, device: device);
        },
      ),
      LatLng(double.parse(device.latitude!), double.parse(device.longitude!)),
    );
  }

  Future<void> googleMapsOnTap(position) async {
    customInfoWindowController.hideInfoWindow!();
    if (selectedMarker != null) {
      selectedMarker = null;
      notifyListeners();
    }
  }

  void onCameraMove(position) => customInfoWindowController.onCameraMove!();

  Future<void> updateDeviceStatus({required bool isOpen, required DeviceModel device}) async {
    if (changingDevice == true) return;
    changingDevice = true;
    final res = await _networkService.start(
      AppEndpoints.updateDeviceStatus,
      httpTypes: HttpTypes.patch,
      data: {
        "serialNumbers": [device.serialNumber],
        "isOpen": isOpen,
      },
    );
    res.fold(
      (error) {
        log('updateDeviceStatus error ${error.message}');
        changingDevice = false;
      },
      (result) {
        if (isOpen) {
          device.deviceStatus = DeviceStatus.Active.name;
        } else {
          device.deviceStatus = DeviceStatus.Passive.name;
        }
        notifyListeners();
        changingDevice = false;
      },
    );
  }

  Future<void> getDeviceDetail({required int? deviceId}) async {
    final res = await _networkService.start(
      AppEndpoints.getDeviceDetail,
      httpTypes: HttpTypes.get,
      queryParameters: {'DeviceId': deviceId},
    );
    return res.fold((error) {
      print('getDeviceDetail error $error');
    }, (result) async {
      var status = BaseModelI.fromJson(result!, DeviceDetailModel()).result!.deviceStatus;
      devices.firstWhere((element) => element.deviceId == deviceId).deviceStatus = status;
      notifyListeners();
    });
  }
}
