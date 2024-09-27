import 'package:coventil/src/core/constants/local/app_locals.dart';
import 'package:coventil/src/core/services/local/local_service.dart';
import 'package:coventil/src/core/services/locator/locator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class OnboardingViewModel extends ChangeNotifier {
  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void forward() {
    if (currentIndex != 2) {
      currentIndex++;
      notifyListeners();
    }
  }

  Future<void> init() async {
    await getIt<LocalService>().write(AppLocals.firstOpen, true);
    FlutterNativeSplash.remove();
  }
}
