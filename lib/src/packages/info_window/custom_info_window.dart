// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Controller to add, update and control the custom info window.
class CustomInfoWindowController {
  /// Add custom [Widget] and [Marker]'s [LatLng] to [MyCustomInfoWindow] and make it visible.
  Function(Widget, LatLng)? addInfoWindow;

  /// Notifies [MyCustomInfoWindow] to redraw as per change in position.
  VoidCallback? onCameraMove;

  /// Hides [MyCustomInfoWindow].
  VoidCallback? hideInfoWindow;

  /// Holds [GoogleMapController] for calculating [MyCustomInfoWindow] position.
  GoogleMapController? googleMapController;

  void dispose() {
    addInfoWindow = null;
    onCameraMove = null;
    hideInfoWindow = null;
    googleMapController = null;
  }
}

/// A stateful widget responsible to create widget based custom info window.
class MyCustomInfoWindow extends StatefulWidget {
  /// A [CustomInfoWindowController] to manipulate [MyCustomInfoWindow] state.
  final CustomInfoWindowController controller;

  /// Offset to maintain space between [Marker] and [MyCustomInfoWindow].
  final double offset;

  /// Height of [MyCustomInfoWindow].
  final double height;

  /// Width of [MyCustomInfoWindow].
  final double width;

  const MyCustomInfoWindow({
    super.key,
    required this.controller,
    this.offset = 50,
    this.height = 50,
    this.width = 100,
  })  : assert(offset >= 0),
        assert(height >= 0),
        assert(width >= 0);

  @override
  _MyCustomInfoWindowState createState() => _MyCustomInfoWindowState();
}

class _MyCustomInfoWindowState extends State<MyCustomInfoWindow> {
  bool _showNow = false;
  double _leftMargin = 0;
  double _topMargin = 0;
  Widget? _child;
  LatLng? _latLng;

  @override
  void initState() {
    super.initState();
    widget.controller.addInfoWindow = _addInfoWindow;
    widget.controller.onCameraMove = _onCameraMove;
    widget.controller.hideInfoWindow = _hideInfoWindow;
  }

  /// Calculate the position on [MyCustomInfoWindow] and redraw on screen.
  void _updateInfoWindow() async {
    if (_latLng == null || _child == null || widget.controller.googleMapController == null) {
      return;
    }
    ScreenCoordinate screenCoordinate =
    await widget.controller.googleMapController!.getScreenCoordinate(_latLng!);
    double devicePixelRatio = Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
    double left = (screenCoordinate.x.toDouble() / devicePixelRatio) - (widget.width / 2);
    double top =
        (screenCoordinate.y.toDouble() / devicePixelRatio) - (widget.offset + widget.height);
    setState(() {
      _showNow = true;
      _leftMargin = left;
      _topMargin = top;
    });
  }

  /// Assign the [Widget] and [Marker]'s [LatLng].
  void _addInfoWindow(Widget child, LatLng latLng) {
    _child = child;
    _latLng = latLng;
    _updateInfoWindow();
  }

  /// Notifies camera movements on [GoogleMap].
  void _onCameraMove() {
    if (!_showNow) return;
    _updateInfoWindow();
  }

  /// Disables [MyCustomInfoWindow] visibility.
  void _hideInfoWindow() {
    setState(() {
      _showNow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20.w,
      right: 20.w,
      bottom: 80.h,
      child: Visibility(
        visible: (_showNow == false ||
            (_leftMargin == 0 && _topMargin == 0) ||
            _child == null ||
            _latLng == null)
            ? false
            : true,
        child: _child ?? const SizedBox.shrink(),
      ),
    );
  }
}
