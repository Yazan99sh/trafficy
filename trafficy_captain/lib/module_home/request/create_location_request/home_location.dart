class CurrentLocation {
  double? lat;
  double? lon;

  CurrentLocation({this.lat, this.lon});

  factory CurrentLocation.fromJson(Map<String, dynamic> json) => CurrentLocation(
        lat: (json['lat'] as num?)?.toDouble(),
        lon: (json['lon'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };
}
