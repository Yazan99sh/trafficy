import 'package:injectable/injectable.dart';
import 'package:trafficy_client/abstracts/module/yes_module.dart';
import 'package:trafficy_client/module_splash/splash_routes.dart';
import 'package:trafficy_client/module_splash/ui/screen/block_screen.dart';
import 'package:trafficy_client/module_splash/ui/screen/splash_screen.dart';

@injectable
class SplashModule extends YesModule {
  SplashModule(SplashScreen splashScreen,BlockScreen blockScreen) {
    YesModule.RoutesMap.addAll(
        {
          SplashRoutes.SPLASH_SCREEN: (context) => splashScreen,
          SplashRoutes.BlOCK_SCREEN: (context) => blockScreen      
        });
  }
}
