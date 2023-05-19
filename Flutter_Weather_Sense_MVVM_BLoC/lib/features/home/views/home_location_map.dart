import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class HomeLocationMap extends StatefulHookWidget {
  /// Describe the current [locationTitle]
  /// of [String] based on [TextFormField] input value.
  final String? locationTitle;

  /// Describe the current [locationSubTitle]
  /// of [String] based on [TextFormField] input value.
  final String? locationSubTitle;

  /// Coordinate location value's of [latitude] which will be
  /// used by [MapboxMap] for building the location point.
  final double? latitude;

  /// Coordinate location value's of [longitude] which will be
  /// used by [MapboxMap] for building the location point.
  final double? longitude;

  const HomeLocationMap({
    super.key,
    this.locationTitle,
    this.locationSubTitle,
    this.latitude,
    this.longitude,
  });

  @override
  State<HomeLocationMap> createState() => _HomeLocationMapState();
}

class _HomeLocationMapState extends State<HomeLocationMap> {
  late final MapboxMapController mapController;

  @override
  void didUpdateWidget(covariant HomeLocationMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("didUpdateWidget");
    if (oldWidget.latitude != widget.latitude ||
        oldWidget.longitude != widget.longitude) {
      debugPrint("Did Update Widget was called");
      debugPrint("Latitude -> ${widget.latitude}");
      debugPrint("Longitude -> ${widget.longitude}");

      _moveCameraPosition(
        controller: mapController,
        latitude: widget.latitude,
        longitude: widget.longitude,
      );

      _addPositionMarker(
        controller: mapController,
        latitude: widget.latitude,
        longitude: widget.longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(
              left: $styles.insets.lg,
              right: $styles.insets.xs,
            ),
            child: Column(
              children: [
                AppAutoResizeText(
                  alignment: Alignment.centerLeft,
                  text: widget.locationTitle ?? "Default Location, ",
                  textAlign: TextAlign.left,
                  textStyle: $styles.textStyle.body1Bold,
                  maxLines: 2,
                ),
                Gap($styles.insets.xs),
                AppAutoResizeText(
                  alignment: Alignment.centerLeft,
                  text: widget.locationSubTitle ?? "Default Location",
                  textAlign: TextAlign.left,
                  textStyle: $styles.textStyle.body5Bold,
                  maxLines: 3,
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(
              left: $styles.insets.sm,
              right: $styles.insets.sm,
            ),
            child: Container(
              padding: EdgeInsets.all($styles.insets.xs),
              height: context.heightPx * 0.15,
              decoration: BoxDecoration(
                color: $styles.colors.tertiary,
                borderRadius: BorderRadius.circular($styles.corners.xs),
              ),
              child: MapboxMap(
                key: widget.key,
                accessToken: $mapBoxAccessToken,
                styleString: $mapBoxStyleUrl,
                myLocationEnabled: true,
                trackCameraPosition: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    widget.latitude ?? -0.02269,
                    widget.longitude ?? 109.344749,
                  ),
                  zoom: 12.0,
                ),
                dragEnabled: false,
                zoomGesturesEnabled: false,
                tiltGesturesEnabled: false,
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: false,
                compassEnabled: false,
                onMapCreated: _onMapCreated,
                attributionButtonMargins: const Point<double>(-100, -100),
                logoViewMargins: const Point<double>(-100, -100),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Initialize the [MapboxMapController] to be able to use
  /// the features of [MapboxMap].
  ///
  /// And then this will move the camera position into
  /// the provided [LatLng] coordinates together with
  /// the relevant position marker.
  Future<void> _onMapCreated(MapboxMapController controller) async {
    mapController = controller;

    await _moveCameraPosition(
      controller: mapController,
      latitude: widget.latitude,
      longitude: widget.longitude,
    );

    await _addPositionMarker(
      controller: mapController,
      latitude: widget.latitude,
      longitude: widget.longitude,
    );
  }

  /// Move camera position into the provided
  /// [latitude] and [longitude] coordinates using
  /// the [MapboxMapController] functionality.
  Future<void> _moveCameraPosition({
    required MapboxMapController controller,
    required double? latitude,
    required double? longitude,
  }) async {
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 270.0,
          tilt: 30.0,
          zoom: 17.0,
          target: LatLng(
            latitude ?? -0.02269,
            longitude ?? 109.344749,
          ),
        ),
      ),
    );
  }

  /// Add position marker into the provided
  /// [latitude] and [longitude] coordinates using
  /// the [MapboxMapController] functionality.
  ///
  /// Before using this method, you must provide
  /// the marker image and using that image to
  /// create the position marker symbol.
  Future<void> _addPositionMarker({
    required MapboxMapController controller,
    required double? latitude,
    required double? longitude,
  }) async {
    final byteData = await rootBundle.load('assets/images/point-marker.png');
    final pointMarkerImage = byteData.buffer.asUint8List();

    await mapController.addImage('pointMarkerImage', pointMarkerImage);

    await mapController.addSymbol(
      SymbolOptions(
        iconSize: 0.3,
        iconImage: 'pointMarkerImage',
        textField: widget.locationTitle ?? "Default Location",
        textSize: 12.5,
        textOffset: const Offset(0, 0.8),
        textAnchor: 'top',
        textColor: '#000000',
        textHaloBlur: 1,
        textHaloColor: '#ffffff',
        textHaloWidth: 0.8,
        geometry: LatLng(
          latitude ?? -0.02269,
          longitude ?? 109.344749,
        ),
      ),
    );
  }
}
