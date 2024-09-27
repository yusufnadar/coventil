import 'dart:developer';

import 'package:coventil/src/core/base/model/base_model.dart';
import 'package:coventil/src/core/constants/end_points/app_end_point.dart';
import 'package:coventil/src/core/constants/enums/http_type_enums.dart';
import 'package:coventil/src/core/helper/mixin/asset_mixin.dart';
import 'package:coventil/src/core/services/network/network_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/constants/enums/device_status.dart';
import '../../add_device_sheet/enum/selected_device_enum.dart';
import '../../home/model/device_model.dart';
import '../model/device_detail_model.dart';

class DeviceDetailViewModel extends ChangeNotifier with AssetMixin {
  DeviceDetailViewModel(this._networkService);

  final NetworkService _networkService;
  DeviceDetailModel? deviceDetail;
  Marker? marker;
  bool changingDevice = false;

  Future<void> getDeviceDetail({required int? deviceId}) async {
    final res = await _networkService.start(
      AppEndpoints.getDeviceDetail,
      httpTypes: HttpTypes.get,
      queryParameters: {'DeviceId': deviceId},
    );
    res.fold((error) {
      print('getDeviceDetail error $error');
    }, (result) async {
      deviceDetail = BaseModelI.fromJson(result!, DeviceDetailModel()).result;
      marker = Marker(
        icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset(
            deviceDetail!.deviceType!.toUpperCase() ==
                    SelectedDeviceEnum.parentDevice.name.toUpperCase()
                ? Assets.icons.mainValve.path
                : Assets.icons.valve.path,
            70.w.toInt(),
          ),
        ),
        markerId: MarkerId(deviceDetail!.deviceId.toString()),
        position: LatLng(
          double.parse(deviceDetail!.latitude!),
          double.parse(deviceDetail!.longitude!),
        ),
      );
      notifyListeners();
    });
  }

  Future<void> updateMainDeviceStatus({required bool isOpen, required String serialNumber}) async {
    /// ANA CİHAZI AÇIP KAPATMA
    if (changingDevice == true) return;
    changingDevice = true;
    final res = await _networkService.start(
      AppEndpoints.updateDeviceStatus,
      httpTypes: HttpTypes.patch,
      data: {
        "serialNumbers": [serialNumber],
        "isOpen": isOpen,
      },
    );
    res.fold(
      (error) {
        log('updateDeviceStatus error ${error.message}');
        changingDevice = false;
      },
      (result) {
        /// ANA CİHAZI KAPANINCA ALT CİHAZLAR DA KAPANIR YA DA AÇILIR
        if (isOpen) {
          deviceDetail?.deviceStatus = DeviceStatus.Active.name;
          notifyListeners();
          for (var item in deviceDetail!.connectedSubDeviceList!) {
            item.status = DeviceStatus.Active.name;
          }
        } else {
          deviceDetail?.deviceStatus = DeviceStatus.Passive.name;
          notifyListeners();
          for (var item in deviceDetail!.connectedSubDeviceList!) {
            item.status = DeviceStatus.Passive.name;
          }
        }
        notifyListeners();
        changingDevice = false;
      },
    );
  }

  Future<void> updateSubDeviceStatus({
    required bool isOpen,
    required String serialNumber,
  }) async {
    /// ALT CİHAZI AÇIP KAPATMA
    if (changingDevice == true) return;
    changingDevice = true;
    final res = await _networkService.start(
      AppEndpoints.updateDeviceStatus,
      httpTypes: HttpTypes.patch,
      data: {
        "serialNumbers": [serialNumber],
        "isOpen": isOpen,
      },
    );
    res.fold(
      (error) {
        log('updateSubDeviceStatus error ${error.message}');
        changingDevice = false;
      },
      (result) {
        /// ALT CİHAZI KAPANINCA VANALAR DA KAPANIR YA DA AÇILIR
        if (isOpen) {
          deviceDetail?.deviceStatus = DeviceStatus.Active.name;
          notifyListeners();
          for (var item in deviceDetail!.connectedValveList!) {
            item.valveStatus = DeviceStatus.Active.name;
          }
        } else {
          deviceDetail?.deviceStatus = DeviceStatus.Passive.name;
          notifyListeners();
          for (var item in deviceDetail!.connectedValveList!) {
            item.valveStatus = DeviceStatus.Passive.name;
          }
        }
        notifyListeners();
        changingDevice = false;
      },
    );
  }

  Future<void> updateMainSubDevicesStatus({
    required bool isOpen,
    required ConnectedSubDeviceList subDevice,
  }) async {
    /// ANA CİHAZIN ALTINDAKİ ALT CİHAZLARI AÇIP KAPATMA
    if (changingDevice == true) return;
    changingDevice = true;
    final res = await _networkService.start(
      AppEndpoints.updateDeviceStatus,
      httpTypes: HttpTypes.patch,
      data: {
        "serialNumbers": [subDevice.serialNumber],
        "isOpen": isOpen,
      },
    );
    res.fold(
      (error) {
        log('updateDeviceStatus error ${error.message}');
        changingDevice = false;
      },
      (result) {
        /// ALT CİHAZ GÜNCELLENİNCE ANA CİHAZ ETKİLENİYORSA EĞER ONU GÜNCELLİYORUZ
        final devices = ListBaseModelI.fromJson(result!, DeviceModel());
        for (var item in devices.result!) {
          if (item.deviceType?.toUpperCase() ==
              SelectedDeviceEnum.parentDevice.name.toUpperCase()) {
            deviceDetail!.deviceStatus = item.status;
            notifyListeners();
          }
        }
        if (isOpen) {
          subDevice.status = DeviceStatus.Active.name;
        } else {
          subDevice.status = DeviceStatus.Passive.name;
        }
        notifyListeners();
        changingDevice = false;
      },
    );
  }

  Future<void> updateSubDeviceValve({required bool isOpen, required int? valveId}) async {
    /// ALT CİHAZIN ALTINDAKİ VANA CİHAZLARINI AÇIP KAPATMA
    if (changingDevice == true) return;
    changingDevice = true;
    final res = await _networkService.start(
      AppEndpoints.updateValveStatus,
      httpTypes: HttpTypes.patch,
      data: {
        "valveId": valveId,
        "isOpen": isOpen,
      },
    );
    res.fold(
      (error) {
        log('updateSubDeviceValve error ${error.message}');
        changingDevice = false;
      },
      (result) {
        /// VANA GÜNCELLENİNCE ALT CİHAZ ETKİLENİYORSA EĞER ONU GÜNCELLİYORUZ
        final devices = ListBaseModelI.fromJson(result!, DeviceModel());
        for (var item in devices.result!) {
          if (item.deviceType?.toUpperCase() ==
              SelectedDeviceEnum.subDevice.name.toUpperCase()) {
            deviceDetail!.deviceStatus = item.status;
            notifyListeners();
          }
        }

        if (isOpen) {
          deviceDetail!.connectedValveList!
              .firstWhere((element) => element.id == valveId)
              .valveStatus = DeviceStatus.Active.name;
          notifyListeners();
        } else {
          deviceDetail!.connectedValveList!
              .firstWhere((element) => element.id == valveId)
              .valveStatus = DeviceStatus.Passive.name;
          notifyListeners();
        }
        notifyListeners();
        changingDevice = false;
      },
    );
  }
}
