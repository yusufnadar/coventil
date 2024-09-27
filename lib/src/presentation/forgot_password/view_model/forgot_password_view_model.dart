import 'package:coventil/src/core/constants/end_points/app_end_point.dart';
import 'package:coventil/src/core/constants/enums/http_type_enums.dart';
import 'package:coventil/src/core/services/network/network_service.dart';
import 'package:flutter/material.dart';

import '../../../core/helper/mixin/toast_message.dart';
import '../model/forgot_password_request_model.dart';

class ForgotPasswordViewModel extends ChangeNotifier with ToastMessage {
  ForgotPasswordViewModel(this._networkService);

  final NetworkService _networkService;
  bool isSuccess = false;
  bool isError = false;
  bool isLoading = false;

  void changeIsError({required bool isError}) {
    this.isError = isError;
    notifyListeners();
  }

  void changeIsLoading(isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future<void> go({required String email}) async {
    if (isLoading == true) return;
    changeIsLoading(true);
    final data = ForgotPasswordRequestModel(email: email);
    final result = await _networkService.start(
      AppEndpoints.forgotPassword,
      httpTypes: HttpTypes.post,
      data: data.toJson(),
    );
    result.fold((_) {
      print(_.message);
      changeIsLoading(false);
    }, (result) {
      isSuccess = true;
      changeIsLoading(false);
      showToast(msg: "Şifre sıfırlama linki başarılı bir şekilde e-posta adresine iletildi.");
    });
  }
}
