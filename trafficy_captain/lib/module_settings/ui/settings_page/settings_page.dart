import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:flutter/material.dart';
import 'package:trafficy_captain/generated/l10n.dart';
import 'package:trafficy_captain/module_auth/authorization_routes.dart';
import 'package:trafficy_captain/module_auth/service/auth_service/auth_service.dart';
import 'package:trafficy_captain/module_home/home_routes.dart';
import 'package:trafficy_captain/module_localization/service/localization_service/localization_service.dart';
import 'package:trafficy_captain/module_theme/service/theme_service/theme_service.dart';
import 'package:trafficy_captain/utils/components/custom_app_bar.dart';
import 'package:trafficy_captain/utils/effect/hidder.dart';

@injectable
class SettingsScreen extends StatefulWidget {
  final AuthService _authService;
  final LocalizationService _localizationService;
  final AppThemeDataService _themeDataService;

  SettingsScreen(
    this._authService,
    this._localizationService,
    this._themeDataService,
  );

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Trafficy.appBar(context,
          title: S.of(context).settings,
          buttonBackground: Theme.of(context).backgroundColor),
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: ListView(
          physics:
              const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Container(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).backgroundColor,
              ),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  ListTileSwitch(
                    value: Theme.of(context).brightness == Brightness.dark,
                    leading: Icon(
                        Theme.of(context).brightness == Brightness.dark
                            ? Icons.nightlight_round_rounded
                            : Icons.wb_sunny),
                    onChanged: (mode) {
                      widget._themeDataService.switchDarkMode(mode);
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    switchActiveColor: Theme.of(context).primaryColor,
                    title: Text(S.of(context).darkMode),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(S.of(context).language),
                    trailing: DropdownButton(
                        value: Localizations.localeOf(context).languageCode,
                        underline: Container(),
                        icon: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.arrow_drop_down_rounded),
                        ),
                        items: [
                           DropdownMenuItem(
                            child: Text('العربية', style: TextStyle(
                              fontFamily: GoogleFonts.balooBhai().fontFamily
                            ),),
                            value: 'ar',
                          ),
                           DropdownMenuItem(
                            child: Text('English',
                            style: TextStyle(
                              fontFamily: GoogleFonts.ubuntu().fontFamily
                            ),
                            ),
                            value: 'en',
                          ),
                        ],
                        onChanged: (newLang) {
                          widget._localizationService
                              .setLanguage(newLang.toString());
                        }),
                  ),
                   ListTile(
                     leading: const Icon(Icons.person_rounded),
                     title: Text(S.of(context).calibration),
                     trailing: const Padding(
                       padding: EdgeInsets.only(right: 10.0, left: 10.0),
                       child: Icon(Icons.location_on_rounded),
                     ),
                     onTap: () {
                         Navigator.of(context).pushNamedAndRemoveUntil(
                             HomeRoutes.CALIBRATION_SCREEN, (route) => false);  
                     },
                   ),
                  Hider(
                    active: widget._authService.isLoggedIn,
                    child: ListTile(
                      leading: const Icon(Icons.person_rounded),
                      title: Text(S.of(context).signOut),
                      trailing: const Padding(
                        padding: EdgeInsets.only(right: 10.0, left: 10.0),
                        child: Icon(Icons.logout_rounded),
                      ),
                      onTap: () {
                        widget._authService.logout().then((value) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AuthorizationRoutes.LOGIN_SCREEN, (route) => false);
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
