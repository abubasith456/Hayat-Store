import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void setStringValue(String key, String value) async {
    try {
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
      print(prefs.get('cnfrmPassword'));
    } catch (e) {
      print(e.toString());
    }
  }

  void setIntValue(String key, int value) async {
    try {
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(key, value);
      print(prefs.get('cnfrmPassword'));
    } catch (e) {
      print(e.toString());
    }
  }

  void setBoolValue(String key, bool value) async {
    try {
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
      print(prefs.get('cnfrmPassword'));
    } catch (e) {
      print(e.toString());
    }
  }
}
