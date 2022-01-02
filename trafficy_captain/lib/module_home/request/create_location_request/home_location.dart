class HomeLocation {
  double? lat;
  double? lon;

  HomeLocation({this.lat, this.lon});

  factory HomeLocation.fromJson(Map<String, dynamic> json) => HomeLocation(
        lat: (json['lat'] as num?)?.toDouble(),
        lon: (json['lon'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };
}
