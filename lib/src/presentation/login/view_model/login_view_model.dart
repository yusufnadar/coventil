import 'package:coventil/src/core/base/model/base_model.dart';
import 'package:coventil/src/core/constants/end_points/app_end_point.dart';
import 'package:coventil/src/core/constants/enums/http_type_enums.dart';
import 'package:coventil/src/core/services/local/local_service.dart';
import 'package:coventil/src/core/services/network/network_service.dart';
import 'package:coventil/src/core/services/route/route_service.dart';
import 'package:coventil/src/presentation/login/model/login_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../common/view_model/user_view_model.dart';
import '../../../core/constants/local/app_locals.dart';
import '../../../core/constants/route/app_routes.dart';
import '../../../core/helper/mixin/toast_message.dart';
import '../../../core/services/locator/locator_service.dart';
import '../model/login_request_model.dart';

class LoginViewModel extends ChangeNotifier with ToastMessage {
  LoginViewModel(this._networkService, this._localService, this._routeService);

  final NetworkService _networkService;
  final LocalService _localService;
  final RouteService _routeService;

  bool obscure = true;
  bool emailError = false;
  bool passwordError = false;
  bool isLoading = false;

  void changeObscure() {
    obscure = !obscure;
    notifyListeners();
  }

  void changeLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> login({required String email, required String password}) async {
    if (isLoading == true) return;
    changeLoading(true);
    final data = TokenRequestModel(
      emailAndPasswordModel: EmailAndPasswordModel(email: email, password: password),
    );
    final res = await _networkService.start(
      AppEndpoints.login,
      httpTypes: HttpTypes.post,
      data: data.toJson(),
    );
    res.fold((error) {
      showToast(msg: error.message ?? '');
      changeLoading(false);
    }, (result) async {
      final res = BaseModelI.fromJson(result!, LoginResponseModel());
      await _localService.write(AppLocals.accessToken, res.result!.token);
      await _localService.write(AppLocals.email, res.result!.email);
      await _localService.write(
          AppLocals.name, '${res.result!.firstName!} ${res.result!.lastName!}');
      await getIt<UserViewModel>().getNotificationState();
      changeLoading(false);
      await _routeService.goRemoveUntil(path: AppRoutes.home);
    });
  }

  void changePasswordError({required bool value}) {
    passwordError = value;
    notifyListeners();
  }

  void changeEmailError({required bool value}) {
    emailError = value;
    notifyListeners();
  }

  void init() => FlutterNativeSplash.remove();

  void clear() {
    emailError = false;
    passwordError = false;
    obscure = true;
    isLoading = false;
    notifyListeners();
  }
}
