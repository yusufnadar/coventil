import 'package:coventil/src/core/constants/color/app_colors.dart';
import 'package:coventil/src/presentation/home/mixin/home_mixin.dart';
import 'package:coventil/src/presentation/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../packages/info_window/custom_info_window.dart';
import '../widget/home_app_bar.dart';
import '../widget/home_google_map.dart';
import '../widget/home_search.dart';

class HomeView extends StatefulWidget {
  final bool? firstOpen;

  const HomeView({super.key, this.firstOpen});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (BuildContext context, model, Widget? child) {
        return Scaffold(
          appBar: model.fullScreenMap == true ? null : const HomeAppBar(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: model.fullScreenMap == false ? buildFloatingActionButton() : null,
          body: SafeArea(
            child: Stack(
              children: [
                buildMap(),
                MyCustomInfoWindow(controller: model.customInfoWindowController),
                const HomeSearch(),
              ],
            ),
          ),
        );
      },
    );
  }

  HomeGoogleMap buildMap() {
    final model = context.read<HomeViewModel>();
    return HomeGoogleMap(
      allMarkers: model.markers.toSet(),
      onCameraMove: model.onCameraMove,
      googleMapsOnTap: model.googleMapsOnTap,
      initialCameraPosition: initialLocation,
      onMapCreated: (GoogleMapController googleMapController) {
        if (!controller.isCompleted) {
          model.customInfoWindowController.googleMapController = googleMapController;
          controller.complete(googleMapController);
        }
      },
    );
  }

  SizedBox buildFloatingActionButton() {
    return SizedBox(
      height: 56.h,
      width: 56.h,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: showAddDeviceSheet,
          backgroundColor: AppColors.primaryGreen,
          shape: const CircleBorder(),
          elevation: 3,
          child: SvgPicture.asset(Assets.icons.add, height: 33.h),
        ),
      ),
    );
  }
}
