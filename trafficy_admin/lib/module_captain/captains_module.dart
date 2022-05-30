import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/module/yes_module.dart';
import 'package:trafficy_admin/module_captain/captains_routes.dart';
import 'package:trafficy_admin/module_captain/sceens/captain_profile_screen.dart';
import 'package:trafficy_admin/module_captain/sceens/captains_screen.dart';

@injectable
class CaptainsModule extends YesModule {
  final CaptainsScreen captainsScreen;
  final CaptainProfileScreen captainProfileScreen;
  CaptainsModule(this.captainsScreen, this.captainProfileScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CaptainRoutes.CAPTAINS_SCREEN: (context) => captainsScreen,
      CaptainRoutes.CAPTAIN_PROFILE_SCREEN: (context) => captainProfileScreen
    };
  }
}
