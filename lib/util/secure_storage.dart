import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyIsLogged = 'isLogged';
  static const _keyNotShowWelcome = 'isNotShowWelcome';

  static Future setIsLogged(String isLogged) async {
    await _storage.write(key: _keyIsLogged, value: isLogged);
  }

  static Future getIsLogged() async {
    await _storage.read(key: _keyIsLogged);
  }

  static Future setIsNotShowWelcome(String isNotShowWelcome) async {
    await _storage.write(key: _keyNotShowWelcome, value: isNotShowWelcome);
  }

  static Future getIsNotShowWelcome() async {
    await _storage.read(key: _keyNotShowWelcome);
  }
}
