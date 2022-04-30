import 'dart:convert';

import 'dart:developer';

class ClientsResponse {
  String? uid;
  CurrentLocation? homeLocation;

  ClientsResponse({this.uid, this.homeLocation});

  factory ClientsResponse.fromJson(Map<String, dynamic> j) {
    // j.remove('\$collection');
    // j.remove('\$write');
    // j.remove('\$read');
    return ClientsResponse(
      uid: j['UID'] as String?,
      homeLocation: j['home_location'] == null
          ? null
          : CurrentLocation.fromJson(j['home_location']),
    );
  }
}

class CurrentLocation {
  double? lat;
  double? lon;

  CurrentLocation({this.lat, this.lon});

  factory CurrentLocation.fromJson(dynamic json) {
    json = jsonDecode(json);
    return CurrentLocation(
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );
  }
  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };
}
