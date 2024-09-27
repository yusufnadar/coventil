import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeGoogleMap extends StatelessWidget {
  final CameraPosition initialCameraPosition;
  final Set<Marker> allMarkers;
  final void Function(CameraPosition)? onCameraMove;
  final void Function(LatLng?) googleMapsOnTap;
  final Function(GoogleMapController googleMapController)? onMapCreated;

  const HomeGoogleMap({
    super.key,
    required this.initialCameraPosition,
    this.onMapCreated,
    required this.allMarkers,
    required this.googleMapsOnTap,
    this.onCameraMove,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      markers: allMarkers,
      onCameraMove: onCameraMove,
      onTap: googleMapsOnTap,
      initialCameraPosition: initialCameraPosition,
      onMapCreated: onMapCreated,
    );
  }
}
