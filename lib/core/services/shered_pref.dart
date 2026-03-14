import 'package:shared_preferences/shared_preferences.dart';

class SheredPref {
  static String nameKey = 'name';
  static String pathKey = 'imagePath';
  static String boolKey = 'boolKey';

  static late final SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setUserInfo(String name, String imagePath) async {
    await prefs.setString(nameKey, name);
    await prefs.setString(pathKey, imagePath);
  }

  // Helper method to save data
  //setString
  static Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  //getString
  static String? getString(String key) {
    return prefs.getString(key) ?? '';
  }

  //
  static Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool? getBool(String key) {
    return prefs.getBool(key) ?? false;
  }
}
