import 'dart:convert';

class CaptainsResponse {
  String? uid;
  CurrentLocation? currentLocation;
  bool? status;
  double? speedInKmh;
  String? name;

  CaptainsResponse(
      {this.uid,
      this.currentLocation,
      this.status,
      this.speedInKmh,
      this.name});

  factory CaptainsResponse.fromJson(Map<String, dynamic> json) {
    if (json['captain'] != null) {
      if (json['captain'] is String) {
        json = jsonDecode(json['captain']);
      } else {
        json = json['captain'];
      }
    }
    return CaptainsResponse(
      uid: json['UID'] as String?,
      status: json['status'],
      speedInKmh: json['speedInKmh']?.toDouble(),
      name: json['name'],
      currentLocation: json['current_location'] == null
          ? null
          : CurrentLocation.fromJson(
              json['current_location'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'captain': {
          'UID': uid,
          'current_location': currentLocation?.toJson(),
          'name': name,
          'speedInKmh': speedInKmh,
          'status': status,
        }
      };
}

class CurrentLocation {
  double? lat;
  double? lon;

  CurrentLocation({this.lat, this.lon});

  factory CurrentLocation.fromJson(Map<String, dynamic> json) =>
      CurrentLocation(
        lat: (json['lat'] as num?)?.toDouble(),
        lon: (json['lon'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };
}
