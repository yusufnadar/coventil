import 'dart:developer';

import 'package:coventil/src/core/base/model/base_model.dart';
import 'package:coventil/src/core/constants/end_points/app_end_point.dart';
import 'package:coventil/src/core/constants/enums/http_type_enums.dart';
import 'package:coventil/src/core/services/network/network_service.dart';
import 'package:flutter/material.dart';

import '../model/search_device_model.dart';

class SearchViewModel extends ChangeNotifier {
  SearchViewModel(this._networkService);

  bool hasFocus = false;
  final NetworkService _networkService;
  final devices = <SearchDeviceModel>[];

  void changeSearch({required bool value}) {
    hasFocus = value;
    notifyListeners();
  }

  Future<void> search(String? value) async {
    final res = await _networkService.start(
      AppEndpoints.search,
      httpTypes: HttpTypes.get,
      queryParameters: {'SearchText': value},
    );
    res.fold(
      (error) {
        log('search error $error');
      },
      (result) {
        print('hey');
        final res = ListBaseModelI.fromJson(result!, SearchDeviceModel());
        devices.clear();
        devices.addAll(res.result!);
        notifyListeners();
      },
    );
  }

  void clear() {
    devices.clear();
    notifyListeners();
  }
}
