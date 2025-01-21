import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String themeKey = 'theme_key';
  static const String languageKey = 'locale_key';

  static Future<void> saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeKey, isDarkMode);
  }

  static Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey) ?? false;
  }

  static Future<void> saveLanguage(String locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(languageKey, locale);
  }

  static Future<String?> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(languageKey);
  }
}
