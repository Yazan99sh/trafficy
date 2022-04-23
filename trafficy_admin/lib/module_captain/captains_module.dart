import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/module/yes_module.dart';
import 'package:trafficy_admin/module_captain/captains_routes.dart';
import 'package:trafficy_admin/module_captain/sceens/captains_screen.dart';

@injectable
class CaptainsModule extends YesModule {
  final CaptainsScreen captainsScreen;
  CaptainsModule(this.captainsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {CaptainRoutes.CAPTAINS_SCREEN: (context) => captainsScreen};
  }
}
