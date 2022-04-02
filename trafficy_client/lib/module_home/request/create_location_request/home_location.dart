import 'dart:convert';

class HomeLocation {
  double? lat;
  double? lon;

  HomeLocation({this.lat, this.lon});

  factory HomeLocation.fromJson(dynamic data) {
    late Map map;
    if (data is String) {
      map = json.decode(data);
    } else {
      map = data;
    }
    return HomeLocation(
      lat: (map['lat'] as num?)?.toDouble(),
      lon: (map['lon'] as num?)?.toDouble(),
    );
  }
  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };
}
