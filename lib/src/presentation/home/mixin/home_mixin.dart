import 'dart:async';

import 'package:coventil/src/presentation/add_device_sheet/view/add_device_sheet_view.dart';
import 'package:coventil/src/presentation/home/view/home_view.dart';
import 'package:coventil/src/presentation/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../common/view_model/user_view_model.dart';
import '../../../core/services/locator/locator_service.dart';
import '../../../core/services/network/network_service.dart';
import '../../../core/services/route/route_service.dart';
import '../../add_device_sheet/view_model/add_device_sheet_view_model.dart';

mixin HomeMixin on State<HomeView> {
  final controller = Completer<GoogleMapController>();

  final focusNode = FocusNode();
  CameraPosition initialLocation = const CameraPosition(
    zoom: 30,
    target: LatLng(40.99587333433724, 29.082077094024173),
  );

  @override
  void initState() {
    super.initState();
    init();
    focusListener();
    getAllDevices();
    getWeathers();
    getIt<UserViewModel>().getNotificationState();
  }

  void focusListener() {
    final model = context.read<HomeViewModel>();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        model.changeHasFocus(value: true);
      } else {
        model.changeHasFocus(value: false);
      }

    });
  }

  void init() => widget.firstOpen == true ? FlutterNativeSplash.remove() : null;

  void showAddDeviceSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => ChangeNotifierProvider(
        create: (BuildContext context) => AddDeviceSheetViewModel(
          getIt<NetworkService>(),
          getIt<RouteService>(),
        ),
        child: const AddDeviceSheetView(),
      ),
    );
  }

  Future<void> getAllDevices() async => context.read<HomeViewModel>().getAllDevices();

  Future<void> getWeathers() async => context.read<HomeViewModel>().getWeathers();
}
/*
  return;
            if (selectedMarker != index) {
              if (selectedMarker != null) {
                markers[selectedMarker!] = markers[selectedMarker!].copyWith(
                  iconParam: BitmapDescriptor.fromBytes(
                    await getBytesFromAsset(Assets.icons.valve.path, 70.w.toInt()),
                  ),
                );
              }
              markers[index] = markers[index].copyWith(
                iconParam: BitmapDescriptor.fromBytes(
                  await getBytesFromAsset(Assets.icons.redValve.path, 70.w.toInt()),
                ),
              );
              selectedMarker = index;
              setState(() {});
              showCustomInfo(markerLocations[index]);
            } else {
              customInfoWindowController.hideInfoWindow!();
              markers[selectedMarker!] = markers[selectedMarker!].copyWith(
                iconParam: BitmapDescriptor.fromBytes(
                  await getBytesFromAsset(Assets.icons.valve.path, 70.w.toInt()),
                ),
              );
              selectedMarker = null;
              setState(() {});
            }

            void getPolygons() {
    allPolygons.add(
      Polygon(
        fillColor: AppColors.green2.withOpacity(0.1),
        strokeWidth: 3,
        geodesic: true,
        strokeColor: AppColors.green2,
        polygonId: const PolygonId('1'),
        points: const [
          LatLng(40.99587333433724, 29.082077094024173),
          LatLng(40.99387333433724, 29.081077094024173),
          LatLng(40.99487333433724, 29.084077094024173),
        ],
      ),
    );
  }
 */
