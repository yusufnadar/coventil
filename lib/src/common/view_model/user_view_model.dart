import 'package:coventil/src/core/constants/local/app_locals.dart';
import 'package:coventil/src/core/constants/route/app_routes.dart';
import 'package:coventil/src/core/services/local/local_service.dart';
import 'package:coventil/src/core/services/route/route_service.dart';
import 'package:flutter/material.dart';

import '../../core/constants/end_points/app_end_point.dart';
import '../../core/constants/enums/http_type_enums.dart';
import '../../core/services/network/network_service.dart';

class UserViewModel extends ChangeNotifier {
  UserViewModel(this._networkService, this._routeService, this._localService);

  final NetworkService _networkService;
  final RouteService _routeService;
  final LocalService _localService;
  bool unReadNotification = false;

  Future<void> logout() async {
    await Future.wait(
      [
        _localService.remove(AppLocals.accessToken),
        _localService.remove(AppLocals.refreshToken),
      ],
    );
    await _routeService.goRemoveUntil(path: AppRoutes.login);
  }

  Future<void> getNotificationState() async {
    final res = await _networkService.start(
      AppEndpoints.notificationState,
      httpTypes: HttpTypes.get,
    );
    res.fold(
      (error) {},
      (result) {
        unReadNotification = result!['result'];
        notifyListeners();
      },
    );
  }
}
