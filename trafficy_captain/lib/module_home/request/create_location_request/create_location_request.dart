import 'dart:convert';

import 'home_location.dart';

class CreateLocationRequest {
  String? uid;
  CurrentLocation? currentLocation;
  bool? status;
  double? speedInKmh;
  String? name;

  CreateLocationRequest(
      {this.uid,
      this.currentLocation,
      this.status,
      this.speedInKmh,
      this.name});

  factory CreateLocationRequest.fromJson(Map<String, dynamic> json) {
    if (json['captain'] != null) {
      if (json['captain'] is String) {
        json = jsonDecode(json['captain']);
      } else {
        json = json['captain'];
      }
    }
    return CreateLocationRequest(
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

  Map<String, String> toJson() {
        var map = {
          'UID': uid,
          'current_location': currentLocation?.toJson(),
          'name': name,
          'speedInKmh': speedInKmh,
          'status': status,
        };
        return {'captain':json.encode(map)}; 
      }
}
