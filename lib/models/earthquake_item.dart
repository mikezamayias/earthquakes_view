import 'dart:convert';

class EarthquakeItem {
  final DateTime date;
  final double latitude;
  final double longitude;
  final double depth;
  final double magnitude;

  EarthquakeItem({
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.depth,
    required this.magnitude,
  });

  EarthquakeItem copyWith({
    DateTime? date,
    double? latitude,
    double? longitude,
    double? depth,
    double? magnitude,
  }) {
    return EarthquakeItem(
      date: date ?? this.date,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      depth: depth ?? this.depth,
      magnitude: magnitude ?? this.magnitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'latitude': latitude,
      'longitude': longitude,
      'depth': depth,
      'magnitude': magnitude,
    };
  }

  factory EarthquakeItem.fromMap(Map<String, dynamic> map) {
    return EarthquakeItem(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      depth: map['depth']?.toDouble() ?? 0.0,
      magnitude: map['magnitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory EarthquakeItem.fromJson(String source) =>
      EarthquakeItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EarthquakeItem(date: $date, latitude: $latitude, longitude: $longitude, depth: $depth, magnitude: $magnitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EarthquakeItem &&
        other.date == date &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.depth == depth &&
        other.magnitude == magnitude;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        depth.hashCode ^
        magnitude.hashCode;
  }
}
