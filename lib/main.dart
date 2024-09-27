import 'package:coventil/src/core/constants/theme/app_themes.dart';
import 'package:coventil/src/core/services/route/app_router.dart';
import 'package:coventil/src/core/services/route/route_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/core/constants/app/app_constants.dart';
import 'src/core/services/init/init_service.dart';
import 'src/core/services/locator/locator_service.dart';

Future<void> main() async {
  await InitService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: AppConstants.path,
      supportedLocales: AppConstants.locals,
      fallbackLocale: const Locale('tr'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              navigatorKey: getIt<RouteService>().navigatorKey,
              onGenerateRoute: AppRouter.generateRoute,
              themeMode: ThemeMode.light,
              theme: AppThemes.lightTheme(),
              darkTheme: AppThemes.lightTheme(),
            ),
          );
        },
      ),
    );
  }
}
