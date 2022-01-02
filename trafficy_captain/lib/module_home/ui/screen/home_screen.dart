import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart' as lat;
import 'package:trafficy_captain/generated/l10n.dart';
import 'package:trafficy_captain/module_deep_links/service/deep_links_service.dart';
import 'package:trafficy_captain/module_home/home_routes.dart';
import 'package:trafficy_captain/module_settings/setting_routes.dart';
import 'package:trafficy_captain/utils/components/custom_app_bar.dart';
import 'package:trafficy_captain/utils/effect/hidder.dart';
import 'package:trafficy_captain/utils/effect/scaling.dart';

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
      var speedInMps = position.speed;
      speedInKm = speedInMps * (18/5);
      var straightDistance = distance.as(
          lat.LengthUnit.Kilometer,
          lat.LatLng(position.latitude, position.longitude),
          defaultUniversityLocation);
      var time = (straightDistance / (speedInMps/1000)) / 60;
      if (time >= 60) {
        timeToArrival = (time / 60).toStringAsFixed(2) + ' ' + S.current.hour;
      } else {
        timeToArrival = time.toStringAsFixed(2) + ' ' + S.current.minute;
      }
      if (timeToArrival == 'Infinity') timeToArrival = null;
      if (speedInKm <= 0.01) timeToArrival = null;
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
          // Google Map
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
          // Mentoring Panel
          Hider(
            active: controller.isCompleted,
            child: ScalingWidget(
              child: Align(
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
                              padding:
                                  const EdgeInsets.only(right: 25.0, left: 25),
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
                                        ? '$timeToArrival'
                                        : '$initDistance ${S.current.km}',
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
                                  LatLng latLng = LatLng(myLocation.latitude,
                                      myLocation.longitude);
                                  GoogleMapController con =
                                      await controller.future;
                                  await con.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
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
                              padding:
                                  const EdgeInsets.only(right: 25.0, left: 25),
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
                                    '${speedInKm.toStringAsFixed(2)} ${S.current.kmh}',
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
            ),
          ),
        ],
      ),
    );
  }
}
