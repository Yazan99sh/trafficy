import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart' as lat;
import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_deep_links/service/deep_links_service.dart';
import 'package:trafficy_client/module_home/home_routes.dart';
import 'package:trafficy_client/module_settings/setting_routes.dart';
import 'package:trafficy_client/utils/components/custom_app_bar.dart';

@injectable
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> controller = Completer();
  double speedInKm = 0.0;
  lat.LatLng defaultUniversityLocation = lat.LatLng(35.0170831, 36.7598127);
  final lat.Distance distance = const lat.Distance();
  String? timeToArrival;
  String initDistance = '';
  @override
  void initState() {
    super.initState();
    DeepLinksService.defaultLocation().then((value) {
      if (value != null) {
        var straightDistance = distance.as(
            lat.LengthUnit.Kilometer,
            lat.LatLng(value.latitude, value.longitude),
            defaultUniversityLocation);
        initDistance = straightDistance.toString();
      } else {
        initDistance = S.current.unknown;
      }
      setState(() {});
    });
    var options = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 10);
    Geolocator.getPositionStream(locationSettings: options).listen((position) {
      var speedInMps = position.speed; // this is your speed
      speedInKm = speedInMps / 1000;
      var straightDistance = distance.as(
          lat.LengthUnit.Kilometer,
          lat.LatLng(position.latitude, position.longitude),
          defaultUniversityLocation);
      timeToArrival = ((straightDistance / (speedInKm)) / 60).toString();
      if (timeToArrival == 'Infinity') timeToArrival = null;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Trafficy.appBar(context,
          title: S.current.home,
          canGoBack: false,
          actions: [
            Trafficy.action(
                icon: Icons.settings,
                onTap: () => Navigator.of(context)
                    .pushNamed(SettingRoutes.ROUTE_SETTINGS),
                context: context)
          ]),
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            child: GoogleMap(
                compassEnabled: false,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController con) {
                  controller.complete(con);
                },
                initialCameraPosition: const CameraPosition(
                    target: LatLng(36.747061, 36.1618916))),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                  ),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0, left: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.university,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                timeToArrival != null
                                    ? '$timeToArrival m'
                                    : '$initDistance km',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.7)),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          thickness: 2.5,
                          indent: 10,
                          endIndent: 10,
                          color: Theme.of(context).backgroundColor,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder()),
                          onPressed: () async {
                            var myLocation =
                                await DeepLinksService.defaultLocation();
                            if (myLocation != null) {
                              LatLng latLng = LatLng(
                                  myLocation.latitude, myLocation.longitude);
                              GoogleMapController con = await controller.future;
                              await con.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                zoom: 19,
                                target: latLng,
                              )));
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        VerticalDivider(
                          thickness: 2.5,
                          indent: 10,
                          endIndent: 10,
                          color: Theme.of(context).backgroundColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0, left: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.weight,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '$speedInKm km/s',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.7)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
