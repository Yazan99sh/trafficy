import 'package:injectable/injectable.dart';
import 'package:trafficy_captain/abstracts/module/yes_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:trafficy_captain/module_home/ui/screen/calibration_screen.dart';
import 'package:trafficy_captain/module_home/ui/screen/home_screen.dart';
import 'home_routes.dart';

@injectable
class HomeModule extends YesModule {
  final CalibrationScreen _calibrationScreen;
  final HomeScreen _homeScreen;
  HomeModule(this._calibrationScreen,this._homeScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      HomeRoutes.CALIBRATION_SCREEN: (context) => _calibrationScreen,
      HomeRoutes.HOME_SCREEN: (context) => _homeScreen
    };
  }
}
