import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  final SharedPreferences? sharedPreferences;

  SharedPrefService({this.sharedPreferences});

  Set<String> getAvailableKeys() => sharedPreferences!.getKeys();

  Object? getData(String key) => sharedPreferences!.get(key);

  Future<bool> remove(String key) => sharedPreferences!.remove(key);

  void setData(String key, String value) async {
    await sharedPreferences?.setString(key, value);
  }

  void clearData() async {
    await sharedPreferences?.clear();
  }
}
