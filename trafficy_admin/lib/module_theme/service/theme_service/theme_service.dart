import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trafficy_admin/di/di_config.dart';
import 'package:trafficy_admin/module_localization/service/localization_service/localization_service.dart';
import 'package:trafficy_admin/module_theme/map_style.dart';
import 'package:trafficy_admin/module_theme/pressistance/theme_preferences_helper.dart';

@injectable
class AppThemeDataService {
  static final PublishSubject<ThemeData> _darkModeSubject =
      PublishSubject<ThemeData>();

  Stream<ThemeData> get darkModeStream => _darkModeSubject.stream;

  final ThemePreferencesHelper _preferencesHelper;

  AppThemeDataService(this._preferencesHelper);

  static Color get PrimaryColor {
    return Colors.purple;
  }

  ThemeData getActiveTheme() {
    var dark = _preferencesHelper.isDarkMode();
    final lightScheme = ColorScheme.fromSeed(seedColor: PrimaryColor);
    final darkScheme = ColorScheme.fromSeed(
        seedColor: PrimaryColor,
        brightness: Brightness.dark,
        error: Colors.red[900],
        errorContainer: Colors.red[100],
        );
    if (dark == true) {
      mapStyle(dark);
      return ThemeData(
          brightness: Brightness.dark,
          colorScheme: darkScheme,
          useMaterial3: true,
          focusColor: PrimaryColor,
          checkboxTheme: CheckboxThemeData(
            checkColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              const Set<MaterialState> interactiveStates = <MaterialState>{
                MaterialState.pressed,
                MaterialState.hovered,
                MaterialState.focused,
              };
              if (states.any(interactiveStates.contains)) {
                return Colors.grey;
              }
              return Colors.white;
            }),
            fillColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              const Set<MaterialState> interactiveStates = <MaterialState>{
                MaterialState.pressed,
                MaterialState.hovered,
                MaterialState.focused,
              };
              if (states.any(interactiveStates.contains)) {
                return Colors.black;
              }
              return Colors.indigo;
            }),
          ),
          cardColor: Colors.grey[150],
          fontFamily: GoogleFonts.cairo().fontFamily,
          textTheme: const TextTheme(
            button: TextStyle(
              color: Colors.white,
            ),
          ));
    }
    mapStyle(dark);
    return ThemeData(
        brightness: Brightness.light,
        colorScheme: lightScheme,
        useMaterial3: true,
        focusColor: PrimaryColor,
        primarySwatch: Colors.purple,
        cardColor: const Color.fromRGBO(245, 245, 245, 1),
        backgroundColor: const Color.fromRGBO(236, 239, 241, 1),
        textTheme: const TextTheme(button: TextStyle(color: Colors.white)),
        fontFamily: GoogleFonts.cairo().fontFamily,
        timePickerTheme: const TimePickerThemeData(
          dialBackgroundColor: Color.fromRGBO(235, 235, 235, 1),
          dayPeriodBorderSide:
              BorderSide(color: Color.fromRGBO(235, 235, 235, 1)),
        ));
  }

  void switchDarkMode(bool darkMode) async {
    if (darkMode) {
      _preferencesHelper.setDarkMode();
    } else {
      _preferencesHelper.setDayMode();
    }
    var activeTheme = getActiveTheme();
    _darkModeSubject.add(activeTheme);
  }

  void mapStyle(bool darkMode) {
    String darkStyle = MapStyle.darkStyle;

    String lightStyle = '''[]''';

    if (darkMode) {
      _preferencesHelper.setMapStyle(darkStyle);
    } else {
      _preferencesHelper.setMapStyle(lightStyle);
    }
  }
}
