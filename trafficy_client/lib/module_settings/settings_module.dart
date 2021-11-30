import 'package:injectable/injectable.dart';
import 'package:trafficy_client/abstracts/module/yes_module.dart';
import 'package:trafficy_client/module_settings/setting_routes.dart';
import 'package:trafficy_client/module_settings/ui/settings_page/settings_page.dart';

@injectable
class SettingsModule extends YesModule {
  final SettingsScreen settingsScreen;
  SettingsModule(this.settingsScreen) {
    YesModule.RoutesMap.addAll({
      SettingRoutes.ROUTE_SETTINGS: (context) => settingsScreen,
    });
  }
}
