import 'package:coventil/src/core/constants/local/app_locals.dart';
import 'package:coventil/src/core/services/local/local_service.dart';
import 'package:coventil/src/core/services/locator/locator_service.dart';
import 'package:coventil/src/core/services/network/network_service.dart';
import 'package:coventil/src/core/services/route/route_service.dart';
import 'package:coventil/src/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:coventil/src/presentation/home/view_model/home_view_model.dart';
import 'package:coventil/src/presentation/onboarding/view/onboarding_view.dart';
import 'package:coventil/src/presentation/onboarding/view_model/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../presentation/add_device_detail/view/add_device_detail_view.dart';
import '../../../presentation/add_device_detail/view_model/add_device_detail_view_model.dart';
import '../../../presentation/forgot_password/view_model/forgot_password_view_model.dart';
import '../../../presentation/home/view/home_view.dart';
import '../../../presentation/login/view/login_view.dart';
import '../../../presentation/login/view_model/login_view_model.dart';
import '../../../presentation/notifications/view/notifications_view.dart';
import '../../../presentation/notifications/view_model/notifications_view_model.dart';
import '../../../presentation/search/view/search_view.dart';
import '../../../presentation/successful_device/view/successful_device_view.dart';
import '../../constants/route/app_routes.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.base:
        if (getIt<LocalService>().read(AppLocals.firstOpen) == null) {
          return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (BuildContext context) => OnboardingViewModel()..init(),
              child: const OnboardingView(firstOpen: true),
            ),
            settings: const RouteSettings(name: AppRoutes.onboarding),
          );
        } else {
          if (getIt<LocalService>().read(AppLocals.accessToken) == null) {
            return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (BuildContext context) => LoginViewModel(
                  getIt<NetworkService>(),
                  getIt<LocalService>(),
                  getIt<RouteService>(),
                ),
                child: const LoginView(firstOpen: true),
              ),
              settings: const RouteSettings(name: AppRoutes.login),
            );
          } else {
            return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (BuildContext context) => HomeViewModel(),
                child: const HomeView(firstOpen: true),
              ),
              settings: const RouteSettings(name: AppRoutes.home),
            );
          }
        }
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => LoginViewModel(
              getIt<NetworkService>(),
              getIt<LocalService>(),
              getIt<RouteService>(),
            ),
            child: const LoginView(),
          ),
          settings: const RouteSettings(name: AppRoutes.login),
        );
      case AppRoutes.addDeviceDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => AddDeviceDetailViewModel(
              getIt<NetworkService>(),
              getIt<RouteService>(),
            ),
            child: AddDeviceDetailView(
              deviceType: args['deviceType'],
              mainDevice: args['mainDevice'],
              subDevice: args['subDevice'],
              mainDeviceSerialNumber: args['mainDeviceSerialNumber'],
            ),
          ),
          settings: const RouteSettings(name: AppRoutes.login),
        );
      case AppRoutes.notifications:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) =>
                NotificationsViewModel(getIt<NetworkService>())..getNotifications(),
            child: const NotificationsView(),
          ),
          settings: const RouteSettings(name: AppRoutes.login),
        );
      case AppRoutes.successfulDevice:
        return MaterialPageRoute(
          builder: (context) => SuccessfulDeviceView(mainDevice: settings.arguments as bool),
          settings: const RouteSettings(name: AppRoutes.successfulDevice),
        );
      case AppRoutes.search:
        return MaterialPageRoute(
          builder: (context) => const SearchView(),
          settings: const RouteSettings(name: AppRoutes.search),
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => ForgotPasswordViewModel(getIt<NetworkService>()),
            child: const ForgotPasswordView(),
          ),
          settings: const RouteSettings(name: AppRoutes.login),
        );
      case AppRoutes.onboarding:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => OnboardingViewModel(),
            child: const OnboardingView(),
          ),
          settings: const RouteSettings(name: AppRoutes.onboarding),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (BuildContext context) => HomeViewModel(),
            child: const HomeView(firstOpen: true),
          ),
          settings: const RouteSettings(name: AppRoutes.home),
        );
    }
    return null;
  }
}
