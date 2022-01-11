import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart' as lat;
import 'package:trafficy_client/abstracts/states/state.dart';
import 'package:trafficy_client/di/di_config.dart';
import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_deep_links/service/deep_links_service.dart';
import 'package:trafficy_client/module_home/state_manager/home_state_manager.dart';
import 'package:trafficy_client/module_home/ui/states/home_state/home_captains_state_loaded.dart';
import 'package:trafficy_client/module_settings/setting_routes.dart';
import 'package:trafficy_client/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:trafficy_client/module_theme/service/theme_service/theme_service.dart';
import 'package:trafficy_client/utils/components/custom_app_bar.dart';

@injectable
class HomeScreen extends StatefulWidget {
  final HomeStateManager _stateManager;
  const HomeScreen(
    this._stateManager,
  );
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  ////////////////////////////////////////////////////////////
  // google map controller
  Completer<GoogleMapController> controller = Completer();
  late CustomInfoWindowController customInfoWindowController;
  // current speed value in km/h
  double speedInKm = 0.0;
  // default defaultUniversityLocation
  lat.LatLng defaultUniversityLocation = lat.LatLng(35.0170831, 36.7598127);
  // distance value between university & home
  final lat.Distance distance = const lat.Distance();
  // time to arrival to university
  String? timeToArrival;
  // initial distance far from university
  String initDistance = '';
  // state variable
  late States currentState;
  ///////////////////////////////////////////////////////////////
  final GlobalKey globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    customInfoWindowController = CustomInfoWindowController();
    currentState = HomeCaptainsStateLoaded(this, captains: []);
    // get current location to calculate initial university distance
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
    widget._stateManager.getCaptains(this);
    getIt<AppThemeDataService>().darkModeStream.listen((event) async {
      GoogleMapController control = await controller.future;
      await control.setMapStyle(getIt<ThemePreferencesHelper>().getStyleMode());
    });
    // state listener
    widget._stateManager.stateSubject.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });

    // Geo Locator work service
    var options = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 10);
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
      setState(() {});
    });
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
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
        body: currentState.getUI(context));
  }
}
