/// A time-limited location share for a vehicle
class LocationShare {
  const LocationShare({
    required this.id,
    required this.name,
    required this.validTill,
  });

  final String id;
  final String name;
  final DateTime validTill;

  bool get isActive => validTill.isAfter(DateTime.now());

  LocationShare copyWith({String? name, DateTime? validTill}) => LocationShare(
        id: id,
        name: name ?? this.name,
        validTill: validTill ?? this.validTill,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'validTill': validTill.toIso8601String(),
      };

  factory LocationShare.fromJson(Map<String, dynamic> json) => LocationShare(
        id: json['id'] as String,
        name: json['name'] as String,
        validTill: DateTime.parse(json['validTill'] as String),
      );
}
