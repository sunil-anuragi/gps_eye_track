import 'package:google_maps_flutter/google_maps_flutter.dart';

enum GeofenceShape { circle, polygon }

/// A saved geofence: a circle (center + radius) or a polygon (points)
class Geofence {
  const Geofence({
    required this.id,
    required this.name,
    required this.shape,
    this.center,
    this.radius = 0,
    this.points = const [],
  });

  final String id;
  final String name;
  final GeofenceShape shape;

  /// Circle only
  final LatLng? center;

  /// Circle only, in metres
  final double radius;

  /// Polygon only
  final List<LatLng> points;

  /// Point to centre the map on
  LatLng get focus {
    if (shape == GeofenceShape.circle || points.isEmpty) {
      return center ?? const LatLng(0, 0);
    }
    final lat = points.map((p) => p.latitude).reduce((a, b) => a + b);
    final lng = points.map((p) => p.longitude).reduce((a, b) => a + b);
    return LatLng(lat / points.length, lng / points.length);
  }

  Geofence copyWith({String? name}) => Geofence(
        id: id,
        name: name ?? this.name,
        shape: shape,
        center: center,
        radius: radius,
        points: points,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'shape': shape.name,
        if (center != null) 'center': [center!.latitude, center!.longitude],
        'radius': radius,
        'points': [
          for (final p in points) [p.latitude, p.longitude],
        ],
      };

  factory Geofence.fromJson(Map<String, dynamic> json) {
    LatLng toLatLng(dynamic v) {
      final list = (v as List).cast<num>();
      return LatLng(list[0].toDouble(), list[1].toDouble());
    }

    return Geofence(
      id: json['id'] as String,
      name: json['name'] as String,
      shape: GeofenceShape.values.byName(json['shape'] as String),
      center: json['center'] == null ? null : toLatLng(json['center']),
      radius: (json['radius'] as num?)?.toDouble() ?? 0,
      points: [
        for (final p in json['points'] as List? ?? []) toLatLng(p),
      ],
    );
  }
}
