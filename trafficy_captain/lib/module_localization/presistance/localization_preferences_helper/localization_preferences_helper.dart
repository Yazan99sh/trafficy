import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class LocalizationPreferencesHelper {
  var prefs = Hive.box('Localization');

  void setLanguage(String lang) {
    prefs.put('lang', lang);
  }

  String? getLanguage() {
    return prefs.get('lang');
  }
}
