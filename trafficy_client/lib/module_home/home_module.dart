import 'package:injectable/injectable.dart';
import 'package:trafficy_client/abstracts/module/yes_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:trafficy_client/module_home/ui/screen/calibration_screen.dart';
import 'home_routes.dart';

@injectable
class HomeModule extends YesModule {
  final CalibrationScreen _calibrationScreen;

  HomeModule(this._calibrationScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      HomeRoutes.CALIBRATION_SCREEN: (context) => _calibrationScreen,
    };
  }
}
