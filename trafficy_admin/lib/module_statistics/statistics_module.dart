import 'package:injectable/injectable.dart';
import 'package:trafficy_admin/abstracts/module/yes_module.dart';
import 'package:trafficy_admin/module_statistics/sceens/preview_screen.dart';
import 'package:trafficy_admin/module_statistics/statistics_routes.dart';

@injectable
class StatisticsModule extends YesModule {
  final PreviewScreen previewScreen;
  StatisticsModule(this.previewScreen) {
    YesModule.RoutesMap.addAll({
      StatisticsRoutes.PREVIEW :(context) => previewScreen
    });
  }
}
