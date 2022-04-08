import 'dart:convert';

import 'home_location.dart';

class CreateLocationRequest {
  String? uid;
  HomeLocation? homeLocation;

  CreateLocationRequest({this.uid, this.homeLocation});

  factory CreateLocationRequest.fromJson(Map<String, dynamic> json) {
    return CreateLocationRequest(
      uid: json['UID'] as String?,
      homeLocation: json['home_location'] == null
          ? null
          : HomeLocation.fromJson(
              json['home_location']),
    );
  }

  Map<String, dynamic> toJson() => {
        'UID': uid,
        'home_location': json.encode(homeLocation?.toJson()),
      };
}
