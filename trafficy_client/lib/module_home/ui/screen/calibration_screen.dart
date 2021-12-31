import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

import 'package:trafficy_client/abstracts/states/state.dart';
import 'package:trafficy_client/di/di_config.dart';
import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_client/module_home/request/create_location_request/create_location_request.dart';
import 'package:trafficy_client/module_home/request/create_location_request/home_location.dart';
import 'package:trafficy_client/module_home/state_manager/calibraion_state_manager.dart';
import 'package:trafficy_client/module_home/ui/states/calibration_init_state.dart';
import 'package:trafficy_client/utils/components/custom_app_bar.dart';

@injectable
class CalibrationScreen extends StatefulWidget {
  final CalibrationStateManager _stateManager;
  const CalibrationScreen(
    this._stateManager,
  );
  @override
  CalibrationScreenState createState() => CalibrationScreenState();
}

class CalibrationScreenState extends State<CalibrationScreen> {
  late States currentState;
  @override
  void initState() {
    super.initState();
    currentState = CalibrationInitState(this);
  }

  void createLocation(LatLng location) {
    widget._stateManager.createLocation(
        this,
        CreateLocationRequest(
            uid: getIt<AuthService>().username,
            homeLocation:
                HomeLocation(lat: location.latitude, lon: location.longitude)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Trafficy.appBar(context, title: S.current.calibration),
      body: currentState.getUI(context),
    );
  }
}
