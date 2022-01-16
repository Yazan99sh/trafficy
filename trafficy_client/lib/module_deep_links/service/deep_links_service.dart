import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:trafficy_client/global_nav_key.dart';
import 'package:trafficy_client/module_splash/splash_routes.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinksService {
  static Future<LatLng?> checkForGeoLink() async {
    var uri = await getInitialUri();

    if (uri == null) {
      return null;
    }
    if (uri.queryParameters['q'] == null) {
      return null;
    }

    return LatLng(
      double.parse(uri.queryParameters['q']!.split(',')[0]),
      double.parse(uri.queryParameters['q']!.split(',')[1]),
    );
  }

  static Future<LatLng?> defaultLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    var myLocation = await Location.instance.getLocation();
    LatLng myPos = LatLng(myLocation.latitude ?? 0, myLocation.longitude ?? 0);
    return myPos;
  }

  static Future<double> getDistance(LatLng headed) async {
    var currentLocation = await defaultLocation();
    if (currentLocation == null) return 0.0;
    var straightDistance =
        const Distance().as(LengthUnit.Kilometer, currentLocation, headed);
    return straightDistance;
  }

  static Future<bool> checkPermission() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    var myLocation = await Location.instance.getLocation();
    return true;
  }
}
