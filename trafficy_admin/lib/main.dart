// ignore_for_file: unused_field

import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:trafficy_admin/abstracts/module/yes_module.dart';
import 'package:trafficy_admin/di/di_config.dart';
import 'package:trafficy_admin/global_nav_key.dart';
import 'package:trafficy_admin/hive/hive_init.dart';
import 'package:trafficy_admin/module_auth/authoriazation_module.dart';
import 'package:trafficy_admin/module_chat/chat_module.dart';
import 'package:trafficy_admin/module_home/home_module.dart';
import 'package:trafficy_admin/module_localization/service/localization_service/localization_service.dart';
import 'package:trafficy_admin/module_settings/settings_module.dart';
import 'package:trafficy_admin/module_splash/splash_module.dart';
import 'package:trafficy_admin/module_theme/service/theme_service/theme_service.dart';
import 'package:trafficy_admin/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'module_splash/splash_routes.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:feature_discovery/feature_discovery.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());
  await HiveSetUp.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    FlutterError.onError = (FlutterErrorDetails details) async {
      Logger().error('Main', details.toString(), StackTrace.current);
    };
    runZonedGuarded(() {
      configureDependencies();
      // Your App Here
      runApp(getIt<MyApp>());
    }, (error, stackTrace) {
      Logger().error(
          'Main', error.toString() + stackTrace.toString(), StackTrace.current);
    });
  });
}

@injectable
class MyApp extends StatefulWidget {
  final AppThemeDataService _themeDataService;
  final LocalizationService _localizationService;
  final SplashModule _splashModule;
  final AuthorizationModule _authorizationModule;
  final SettingsModule _settingsModule;
  final ChatModule _chatModule;
  final HomeModule _homeModule;

  const MyApp(
      this._themeDataService,
      this._localizationService,
      this._splashModule,
      this._authorizationModule,
      this._chatModule,
      this._settingsModule,
      this._homeModule);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late String lang;
  late ThemeData activeTheme;
  bool authorized = false;

  @override
  void initState() {
    super.initState();
    lang = widget._localizationService.getLanguage();
    activeTheme = widget._themeDataService.getActiveTheme();
    timeago.setDefaultLocale(lang);
    Moment.setLocaleGlobally(lang == 'en' ? LocaleEn() : LocaleAr());
    widget._localizationService.localizationStream.listen((event) {
      timeago.setDefaultLocale(event);
      Moment.setLocaleGlobally(event == 'en' ? LocaleEn() : LocaleAr());
      lang = event;
      activeTheme = widget._themeDataService.getActiveTheme();
      setState(() {});
    });
    widget._themeDataService.darkModeStream.listen((event) {
      activeTheme = event;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return getConfiguratedApp(YesModule.RoutesMap);
  }

  Widget getConfiguratedApp(
    Map<String, WidgetBuilder> fullRoutesList,
  ) {
    return FeatureDiscovery(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: GlobalVariable.navState,
        locale: Locale.fromSubtags(
          languageCode: lang,
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: activeTheme,
        supportedLocales: S.delegate.supportedLocales,
        title: 'Trafficy',
        routes: fullRoutesList,
        initialRoute: SplashRoutes.SPLASH_SCREEN,
      ),
    );
  }
}
