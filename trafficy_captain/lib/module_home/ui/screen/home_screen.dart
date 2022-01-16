import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart' as lat;
import 'package:trafficy_captain/di/di_config.dart';
import 'package:trafficy_captain/generated/l10n.dart';
import 'package:trafficy_captain/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_captain/module_auth/ui/widget/stop_watch.dart';
import 'package:trafficy_captain/module_deep_links/service/deep_links_service.dart';
import 'package:trafficy_captain/module_home/request/create_location_request/create_location_request.dart';
import 'package:trafficy_captain/module_home/request/create_location_request/home_location.dart';
import 'package:trafficy_captain/module_home/state_manager/home_state_manager.dart';
import 'package:trafficy_captain/module_settings/setting_routes.dart';
import 'package:trafficy_captain/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:trafficy_captain/module_theme/service/theme_service/theme_service.dart';
import 'package:trafficy_captain/utils/components/custom_app_bar.dart';
import 'package:trafficy_captain/utils/effect/hidder.dart';
import 'package:trafficy_captain/utils/effect/scaling.dart';

@injectable
class HomeScreen extends StatefulWidget {
  final HomeStateManager _stateManager;
  const HomeScreen(
    this._stateManager,
  );
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Completer<GoogleMapController> controller = Completer();
  double speedInKm = 0.0;
  lat.LatLng defaultUniversityLocation = lat.LatLng(35.0170831, 36.7598127);
  final lat.Distance distance = const lat.Distance();
  String? timeToArrival;
  String initDistance = '';
  late AnimationController animationController;
  Stream<int>? timerStream;
  StreamSubscription<int>? timerSubscription;
  String hoursStr = '00';
  String minutesStr = '00';
  String secondsStr = '00';
  bool feed = false;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    getIt<AppThemeDataService>().darkModeStream.listen((event) async {
      GoogleMapController control = await controller.future;
      await control.setMapStyle(getIt<ThemePreferencesHelper>().getStyleMode());
    });

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
      accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 100);
    Geolocator.getPositionStream(locationSettings: options).listen((position) {
      var speedInMps = position.speed;
      speedInKm = speedInMps * (18 / 5);
      var straightDistance = distance.as(
          lat.LengthUnit.Kilometer,
          lat.LatLng(position.latitude, position.longitude),
          defaultUniversityLocation);
      var time = (straightDistance / (speedInMps / 1000)) / 60;
      if (time >= 60) {
        timeToArrival = (time / 60).toStringAsFixed(2) + ' ' + S.current.hour;
      } else {
        timeToArrival = time.toStringAsFixed(2) + ' ' + S.current.minute;
      }
      if (timeToArrival == 'Infinity') timeToArrival = null;
      if (speedInKm <= 0.01) timeToArrival = null;
      if (play && feed) {
        widget._stateManager.updateLocation(
            this,
            CreateLocationRequest(
              uid: getIt<AuthService>().username,
              status: true,
              speedInKmh: speedInKm,
              currentLocation: CurrentLocation(
                  lat: position.latitude, lon: position.longitude),
            ));
      }
      setState(() {});
    });
  }

  bool play = false;
  animate() =>
      play ? animationController.reverse() : animationController.forward();
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
                onTap: (location) {},
                onCameraMove: (ca) {},
                onMapCreated: (GoogleMapController con) {
                  controller.complete(con);
                },
                initialCameraPosition: const CameraPosition(
                    zoom: 6,
                    target: LatLng(35.1994366003667, 38.592870868742466))),
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
                            // clock
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 25.0, left: 25),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.busAlt,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '$minutesStr:$secondsStr',
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
                            // Action Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder()),
                              onPressed: () async {
                                animate();
                                play = play ? false : true;

                                var myLocation =
                                    await DeepLinksService.defaultLocation();

                                if (myLocation != null) {
                                  var request = CreateLocationRequest(
                                    uid: getIt<AuthService>().username,
                                    status: null,
                                    speedInKmh: 0.0,
                                    currentLocation: CurrentLocation(
                                        lat: myLocation.latitude,
                                        lon: myLocation.longitude),
                                  );
                                  if (play) {
                                    request.status = true;
                                    timerStream = stopWatchStream();
                                    timerSubscription =
                                        timerStream?.listen((int newTick) {
                                      if (mounted) {
                                        setState(() {
                                          hoursStr =
                                              ((newTick / (60 * 60)) % 60)
                                                  .floor()
                                                  .toString()
                                                  .padLeft(2, '0');
                                          minutesStr = ((newTick / 60) % 60)
                                              .floor()
                                              .toString()
                                              .padLeft(2, '0');
                                          secondsStr = (newTick % 60)
                                              .floor()
                                              .toString()
                                              .padLeft(2, '0');
                                        });
                                      }
                                    });
                                  } else {
                                    request.status = false;
                                    timerSubscription?.cancel();
                                    timerStream = null;
                                    setState(() {
                                      hoursStr = '00';
                                      minutesStr = '00';
                                      secondsStr = '00';
                                    });
                                  }
                                  widget._stateManager
                                      .updateLocation(this, request);
                                  LatLng latLng = LatLng(myLocation.latitude,
                                      myLocation.longitude);
                                  GoogleMapController con =
                                      await controller.future;
                                  if (play) {
                                    // send location
                                    await con.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                      zoom: 19,
                                      target: latLng,
                                    )));
                                    feed = true;
                                  } else {
                                    await con.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                      zoom: 12,
                                      target: latLng,
                                    )));
                                    feed = false;
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: AnimatedIcon(
                                  progress: animationController,
                                  icon: AnimatedIcons.play_pause,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // speed meter
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
