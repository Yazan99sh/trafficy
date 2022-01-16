import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trafficy_captain/di/di_config.dart';
import 'package:trafficy_captain/module_localization/service/localization_service/localization_service.dart';
import 'package:trafficy_captain/module_theme/map_style.dart';
import 'package:trafficy_captain/module_theme/pressistance/theme_preferences_helper.dart';

@injectable
class AppThemeDataService {
  static final PublishSubject<ThemeData> _darkModeSubject =
      PublishSubject<ThemeData>();

  Stream<ThemeData> get darkModeStream => _darkModeSubject.stream;

  final ThemePreferencesHelper _preferencesHelper;

  AppThemeDataService(this._preferencesHelper);

  static Color get primaryColor {
    return Colors.purple;
  }

  static Color get primaryDarker {
    return Colors.purple;
  }

  static Color get accentColor {
    return Colors.purpleAccent;
  }

  ThemeData getActiveTheme() {
    var dark = _preferencesHelper.isDarkMode();
    if (dark == true) {
      mapStyle(dark);
      return ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        primaryColorDark: primaryDarker,
        focusColor: primaryColor,
        fontFamily: getIt<LocalizationService>().getLanguage() == 'ar'
            ? GoogleFonts.balooBhai().fontFamily
            : GoogleFonts.ubuntu().fontFamily,
        backgroundColor: const Color.fromRGBO(36, 34, 38, 1),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: accentColor, brightness: Brightness.dark),
      );
    }
    mapStyle(dark);
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        primaryColorDark: primaryDarker,
        focusColor: primaryColor,
        cardColor: const Color.fromRGBO(245, 245, 245, 1),
        // const Color.fromRGBO(236, 239, 241, 1)
        backgroundColor: const Color.fromRGBO(246, 235, 255, 1),
        fontFamily: getIt<LocalizationService>().getLanguage() == 'ar'
            ? GoogleFonts.balooBhai().fontFamily
            : GoogleFonts.ubuntu().fontFamily,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(246, 235, 255, 1),
        ),
        timePickerTheme: const TimePickerThemeData(
          dialBackgroundColor: Color.fromRGBO(235, 235, 235, 1),
          dayPeriodBorderSide:
              BorderSide(color: Color.fromRGBO(235, 235, 235, 1)),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: accentColor));
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
