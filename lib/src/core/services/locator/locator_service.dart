import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import '../../../common/view_model/user_view_model.dart';
import '../local/local_service.dart';
import '../network/network_service.dart';
import '../route/route_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NetworkService>(
    () => NetworkService(Dio()..httpClientAdapter = HttpClientAdapter(), getIt<LocalService>())
      ..init(),
  );
  getIt.registerSingleton<LocalService>(
    LocalService(GetStorage())..init(),
  );
  getIt.registerSingleton<RouteService>(RouteService());
  getIt.registerSingleton<UserViewModel>(
    UserViewModel(
      getIt<NetworkService>(),
      getIt<RouteService>(),
      getIt<LocalService>(),
    ),
  );
}
