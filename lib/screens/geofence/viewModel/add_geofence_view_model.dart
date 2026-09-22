import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_software/screens/geofence/model/geofence.dart';
import 'package:gps_software/screens/geofence/widgets/create_geofence_dialog.dart';
import 'package:gps_software/util/base_controller.dart';

class AddGeofenceViewModel extends BaseController {
  static const double minRadius = 100;
  static const double maxRadius = 3000;
  static const LatLng _fallbackTarget = LatLng(28.6139, 77.2090);

  static const Color _strokeColor = Colors.black;
  static final Color _fillColor =
      const Color(0xff9e9e9e).withValues(alpha: 0.5);

  /// Geofence being changed, null when adding a new one
  Geofence? editing;

  GoogleMapController? mapController;
  late final CameraPosition initialCamera;

  final shape = GeofenceShape.circle.obs;
  final radius = 400.0.obs;
  final center = Rxn<LatLng>();
  final points = <LatLng>[].obs;

  /// Map centre, used to place the circle when none is drawn
  late LatLng _cameraTarget;

  @override
  void onInit() {
    super.onInit();
    editing = Get.arguments as Geofence?;
    final g = editing;
    if (g != null) {
      shape.value = g.shape;
      if (g.shape == GeofenceShape.circle) {
        center.value = g.center;
        radius.value = g.radius.clamp(minRadius, maxRadius);
      } else {
        points.assignAll(g.points);
      }
    }
    _cameraTarget = g?.focus ?? _fallbackTarget;
    initialCamera = CameraPosition(target: _cameraTarget, zoom: 14.5);
    center.value ??= g == null ? _cameraTarget : null;
  }

  void onMapCreated(GoogleMapController controller) =>
      mapController = controller;

  void onCameraMove(CameraPosition position) => _cameraTarget = position.target;

  void selectShape(GeofenceShape value) {
    if (shape.value == value) return;
    shape.value = value;
    if (value == GeofenceShape.circle) {
      center.value ??= _cameraTarget;
    }
  }

  void onMapTap(LatLng latLng) {
    if (shape.value == GeofenceShape.circle) {
      center.value = latLng;
    } else {
      points.add(latLng);
    }
  }

  void onRadiusChanged(double value) =>
      radius.value = (value / 10).roundToDouble() * 10;

  void clear() {
    if (shape.value == GeofenceShape.circle) {
      center.value = null;
    } else {
      points.clear();
    }
  }

  void zoom(bool zoomIn) => mapController
      ?.animateCamera(zoomIn ? CameraUpdate.zoomIn() : CameraUpdate.zoomOut());

  Set<Marker> get markers {
    if (shape.value == GeofenceShape.circle) {
      final c = center.value;
      if (c == null) return {};
      return {
        Marker(
          markerId: const MarkerId('center'),
          position: c,
          draggable: true,
          onDragEnd: (p) => center.value = p,
        ),
      };
    }
    return {
      for (var i = 0; i < points.length; i++)
        Marker(
          markerId: MarkerId('point_$i'),
          position: points[i],
          draggable: true,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          onDragEnd: (p) => points[i] = p,
        ),
    };
  }

  Set<Circle> get circles {
    final c = center.value;
    if (shape.value != GeofenceShape.circle || c == null) return {};
    return {
      Circle(
        circleId: const CircleId('geofence'),
        center: c,
        radius: radius.value,
        strokeColor: _strokeColor,
        strokeWidth: 3,
        fillColor: _fillColor,
      ),
    };
  }

  Set<Polygon> get polygons {
    if (shape.value != GeofenceShape.polygon || points.length < 2) return {};
    return {
      Polygon(
        polygonId: const PolygonId('geofence'),
        points: points.toList(),
        strokeColor: _strokeColor,
        strokeWidth: 3,
        fillColor: _fillColor,
      ),
    };
  }

  Future<void> save() async {
    final isCircle = shape.value == GeofenceShape.circle;
    if (isCircle && center.value == null) {
      showSnack(msg: 'Tap on the map to place the geofence');
      return;
    }
    if (!isCircle && points.length < 3) {
      showSnack(msg: 'Tap at least 3 points on the map');
      return;
    }

    final name = await showCreateGeofenceDialog(initialName: editing?.name);
    if (name == null) return;

    Get.back(
      result: Geofence(
        id: editing?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        shape: shape.value,
        center: isCircle ? center.value : null,
        radius: isCircle ? radius.value : 0,
        points: isCircle ? const [] : points.toList(),
      ),
    );
  }

  @override
  void onClose() {
    mapController?.dispose();
    super.onClose();
  }
}
