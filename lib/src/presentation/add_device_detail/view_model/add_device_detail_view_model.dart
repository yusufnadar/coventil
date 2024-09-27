import 'package:coventil/src/common/model/value/value_model.dart';
import 'package:coventil/src/core/base/model/base_model.dart';
import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:coventil/src/core/constants/end_points/app_end_point.dart';
import 'package:coventil/src/core/constants/enums/http_type_enums.dart';
import 'package:coventil/src/core/constants/route/app_routes.dart';
import 'package:coventil/src/core/services/network/network_service.dart';
import 'package:coventil/src/core/services/route/route_service.dart';
import 'package:coventil/src/presentation/add_device_detail/model/add_main_device_model.dart';
import 'package:coventil/src/presentation/add_device_sheet/enum/selected_device_enum.dart';
import 'package:coventil/src/presentation/add_device_sheet/model/validate_main_device_model.dart';
import 'package:coventil/src/presentation/add_device_sheet/model/validate_sub_device_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/add_sub_device_model.dart';

class AddDeviceDetailViewModel extends ChangeNotifier {
  AddDeviceDetailViewModel(this._networkService, this._routeService);

  final NetworkService _networkService;
  final RouteService _routeService;
  bool valveIsActive = false;
  bool isActive = false;
  bool mainDeviceActive = false;
  final nameController = TextEditingController();
  int currentIndex = 0;
  int? cityId;
  int? districtId;
  int? conductingId;
  int? parkId;
  int valveCount = 1;
  var valveControllers = <TextEditingController>[TextEditingController()];
  final cities = <ValueModel>[];
  final districts = <ValueModel>[];
  final conducting = <ValueModel>[];
  final parks = <ValueModel>[];

  Future<void> init({required SelectedDeviceEnum deviceType}) async {
    await getCities();
    await getDistricts(
      cityId: cities.firstWhere((element) => element.value == 'İstanbul').id!,
    );
  }

  Future<void> getCities() async {
    final res = await _networkService.start(AppEndpoints.allCities, httpTypes: HttpTypes.get);
    res.fold(
      (error) {
        print('GET CITIES REQUEST ERROR $error');
      },
      (result) {
        final res = ListBaseModelI.fromJson(result!, ValueModel());
        cities.clear();
        cities.addAll(res.result!);
        cityId = cities.firstWhere((element) => element.value == 'İstanbul').id;
        notifyListeners();
      },
    );
  }

  Future<void> getDistricts({required int cityId, SelectedDeviceEnum? deviceType}) async {
    final res = await _networkService.start(
      AppEndpoints.allDistricts,
      httpTypes: HttpTypes.get,
      queryParameters: {'cityId': cityId},
    );
    res.fold(
      (error) {
        print('GET DISTRICTS REQUEST ERROR ${error.message}');
      },
      (result) {
        final res = ListBaseModelI.fromJson(result!, ValueModel());
        districts.clear();
        districts.addAll(res.result!);
        notifyListeners();
      },
    );
  }

  Future<void> getConducting({required int districtId}) async {
    final res = await _networkService.start(
      AppEndpoints.allConducting,
      httpTypes: HttpTypes.get,
      queryParameters: {'countryId': districtId},
    );
    res.fold(
      (error) {
        print('getConducting REQUEST ERROR $error');
      },
      (result) {
        final res = ListBaseModelI.fromJson(result!, ValueModel());
        conducting.clear();
        conducting.addAll(res.result!);
        notifyListeners();
      },
    );
  }

  Future<void> getParks({required int conductingId}) async {
    final res = await _networkService.start(
      AppEndpoints.allParks,
      httpTypes: HttpTypes.get,
      queryParameters: {'cheftaincyId': conductingId},
    );
    res.fold(
      (error) {
        print('getParks REQUEST ERROR $error');
      },
      (result) {
        final res = ListBaseModelI.fromJson(result!, ValueModel());
        parks.clear();
        parks.addAll(res.result!);
        notifyListeners();
      },
    );
  }

  Color buttonColor({required SelectedDeviceEnum deviceType}) {
    if (deviceType == SelectedDeviceEnum.subDevice) {
      if (currentIndex == 0 && isActive == true) {
        return AppColors.primaryGreen;
      } else if (currentIndex == 1 && valveIsActive == true) {
        return AppColors.primaryGreen;
      } else {
        return AppColors.gray;
      }
    } else {
      if (mainDeviceActive == true) {
        return AppColors.primaryGreen;
      } else {
        return AppColors.gray;
      }
    }
  }

  ///// COMMON FUNCTIONS

  void changeCurrentIndex({required int index}) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> onTap({
    required SelectedDeviceEnum type,
    required ValidateMainDeviceModel? mainDevice,
    required ValidateSubDeviceModel? subDevice,
    required String? mainDeviceSerialNumber,
  }) async {
    if (type == SelectedDeviceEnum.parentDevice) {
      final addMainDeviceModel = AddMainDeviceModel(
        name: nameController.text,
        cityId: cityId,
        countryId: districtId,
        cheftaincyId: 1,
        parkAndGardenId: 1,
        serialNumber: mainDevice?.data?.id,
        latitude: mainDevice?.data?.location?.latitude.toString(),
        longitude: mainDevice?.data?.location?.longitude.toString(),
      );
      if (mainDeviceActive == true) {
        final res = await _networkService.start(
          AppEndpoints.createMainDevice,
          httpTypes: HttpTypes.post,
          data: addMainDeviceModel.toJson(),
        );
        res.fold((error) {
          print('createMainDevice request error $error');
        }, (result) async {
          await _routeService.goRemoveUntil(path: AppRoutes.successfulDevice,data: true);
        });
      }
    } else {
      if (currentIndex == 0) {
        if (isActive == true) {
          changeCurrentIndex(index: 1);
        }
      } else {
        if (valveIsActive == true) {
          final permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            await Geolocator.requestPermission();
          } else if (permission == LocationPermission.denied ||
              permission == LocationPermission.unableToDetermine) {
            openAppSettings();
          } else if (permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always) {
            final currentPosition = await Geolocator.getCurrentPosition();
            final addSubDeviceModel = AddSubDeviceModel(
              name: nameController.text,
              cityId: cityId,
              countryId: districtId,
              cheftaincyId: conductingId,
              parkAndGardenId: parkId,
              valveNames: valveControllers.map((e) => e.text).toList(),
              valveCount: valveControllers.length,
              parentDeviceSerialNumber: mainDeviceSerialNumber,
              serialNumber: subDevice!.data!.id,
              rainSensorSlotCount: subDevice.data!.controllers!.rainSensorCount,
              soilSensorSlotCount: subDevice.data!.controllers!.soilSensorCount,
              longitude: currentPosition.longitude.toString(),
              latitude: currentPosition.latitude.toString(),
            );
            final res = await _networkService.start(
              AppEndpoints.createSubDevice,
              httpTypes: HttpTypes.post,
              data: addSubDeviceModel.toJson(),
            );
            res.fold(
              (error) {
                print('create sub device error $error');
              },
              (result) async {
                print('İŞLEM BAŞARILI');
                await _routeService.goRemoveUntil(path: AppRoutes.successfulDevice,data: false);
              },
            );
          }
        }
      }
    }
  }

  ///// CURRENT INDEX 0
  void changeIsActive(value) {
    isActive = value;
    notifyListeners();
  }

  void changeMainDeviceActive(value) {
    mainDeviceActive = value;
    notifyListeners();
  }

  void controlIsActive() {
    if (cityId != null &&
        districtId != null &&
        conductingId != null &&
        parkId != null &&
        nameController.text != '') {
      changeIsActive(true);
    } else {
      changeIsActive(false);
    }
  }

  void controlMainDeviceActive() {
    if (cityId != null && districtId != null && nameController.text != '') {
      changeMainDeviceActive(true);
    } else {
      changeMainDeviceActive(false);
    }
  }

  void changeCity(int? cityId, SelectedDeviceEnum deviceType) {
    this.cityId = cityId;
    districtId = null;
    conductingId = null;
    parkId = null;
    conducting.clear();
    parks.clear();
    changeMainDeviceActive(false);
    notifyListeners();
    getDistricts(cityId: cityId!, deviceType: deviceType);
  }

  void changeDistrict(int? districtId, SelectedDeviceEnum deviceType) {
    this.districtId = districtId;
    conductingId = null;
    parkId = null;
    parks.clear();
    notifyListeners();
    if (deviceType == SelectedDeviceEnum.parentDevice) {
      controlMainDeviceActive();
    } else {
      conductingId = null;
      getConducting(districtId: districtId!);
    }
  }

  void changeConducting(int? conductingId) {
    this.conductingId = conductingId;
    parkId = null;
    getParks(conductingId: conductingId!);
  }

  void changePark(int? parkId) {
    this.parkId = parkId;
    controlIsActive();
  }

  ///// CURRENT INDEX 1

  void changeValveIsActive(value) {
    valveIsActive = value;
    notifyListeners();
  }

  void changeValveCount(int? count) {
    valveCount = count!;
    notifyListeners();
    valveControllers.clear();
    for (int i = 0; i < count; i++) {
      valveControllers.add(TextEditingController());
    }
    changeValveIsActive(false);
    notifyListeners();
  }

  void controlValveIsActive(String? value) {
    for (var item in valveControllers) {
      if (item.text == '') {
        changeValveIsActive(false);
        return;
      }
    }
    changeValveIsActive(true);
  }
}
