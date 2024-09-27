// ignore_for_file: use_build_context_synchronously

import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../../../../firebase_options.dart';
import '../../../../main.dart';
import '../../../common/view_model/user_view_model.dart';
import '../locator/locator_service.dart';

class InitService {
  static Future<void> init() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: binding);
    setupLocator();
    await getIt.allReady();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
    );
    await Geolocator.requestPermission();
    await EasyLocalization.ensureInitialized();
    await GetStorage.init();

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserViewModel>(create: (context) => getIt<UserViewModel>()),
        ],
        child: const MyApp(),
      ),
    );
  }
}
