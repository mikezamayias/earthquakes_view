import 'dart:convert';

class EarthquakeEvent {
  final int id;
  final DateTime date;
  final double latitude;
  final double longitude;
  final double depth;
  final double magnitude;

  EarthquakeEvent({
    required this.id,
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.depth,
    required this.magnitude,
  });

  EarthquakeEvent copyWith({
    int? id,
    DateTime? date,
    double? latitude,
    double? longitude,
    double? depth,
    double? magnitude,
  }) {
    return EarthquakeEvent(
      id: id ?? this.id,
      date: date ?? this.date,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      depth: depth ?? this.depth,
      magnitude: magnitude ?? this.magnitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'latitude': latitude,
      'longitude': longitude,
      'depth': depth,
      'magnitude': magnitude,
    };
  }

  factory EarthquakeEvent.fromMap(Map<String, dynamic> map) {
    return EarthquakeEvent(
      id: map['id']?.toInt() ?? 0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      depth: map['depth']?.toDouble() ?? 0.0,
      magnitude: map['magnitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory EarthquakeEvent.fromJson(String source) =>
      EarthquakeEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EarthquakeEvent(id: $id, date: $date, latitude: $latitude, longitude: $longitude, depth: $depth, magnitude: $magnitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EarthquakeEvent &&
      other.id == id &&
      other.date == date &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.depth == depth &&
      other.magnitude == magnitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      date.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      depth.hashCode ^
      magnitude.hashCode;
  }
}
