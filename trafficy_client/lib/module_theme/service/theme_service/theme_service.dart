import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trafficy_client/module_theme/pressistance/theme_preferences_helper.dart';

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
      return ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        primaryColorDark: primaryDarker,
        focusColor: primaryColor,
        cardColor: Colors.grey[150],
        fontFamily: GoogleFonts.damion().fontFamily,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: accentColor),
      );
    }
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        primaryColorDark: primaryDarker,
        focusColor: primaryColor,
        cardColor: const Color.fromRGBO(245, 245, 245, 1),
        // const Color.fromRGBO(236, 239, 241, 1)
        backgroundColor: const Color.fromRGBO(246,235,255, 1),
        fontFamily: GoogleFonts.damion().fontFamily,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 18,
          ),
          headline5: TextStyle(
            fontSize: 18,
          ),
          headline2: TextStyle(
            fontSize: 18,
          ),
          headline3: TextStyle(
            fontSize: 18,
          ),
          headline4: TextStyle(
            fontSize: 18,
          ),
           headline6: TextStyle(
            fontSize: 18,
          ),
          subtitle1: TextStyle(
            fontSize: 18,
          ),
          subtitle2: TextStyle(
            fontSize: 18,
          ),
          bodyText1: TextStyle(
            fontSize: 18,
          ),
          bodyText2: TextStyle(
            fontSize: 18,
          ),
          overline: TextStyle(
            fontSize: 18,
          ),
          caption: TextStyle(
            fontSize: 18,
          ),
          button: TextStyle(
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(246,235,255, 1),
        ),
        timePickerTheme: const TimePickerThemeData(
          dialBackgroundColor: Color.fromRGBO(235, 235, 235, 1),
          dayPeriodBorderSide:
              BorderSide(color: Color.fromRGBO(235, 235, 235, 1)),
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: accentColor));
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
}
