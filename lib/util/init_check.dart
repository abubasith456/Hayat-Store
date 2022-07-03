import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

//Using static private field with getter
class InitialChecking {
  InitialChecking._privateConstructor();

  static final InitialChecking _instance =
      InitialChecking._privateConstructor();

  static InitialChecking get instance {
    return _instance;
  }

  late bool _isLogged;
  late bool _isNotShowWelcome;

  bool get isLogged => _isLogged;
  bool get isNotShowWelcome => _isNotShowWelcome;

  Future getIsLogged() async {
    final prefs = await SharedPreferences.getInstance();
    bool? tempLogging = prefs.get(loggedKey) as bool?;
    bool? tempFirstLog = prefs.get(isFirstLogin) as bool?;
    _isLogged = tempLogging!;
    _isNotShowWelcome = tempFirstLog!;
  }
}

// class InitialChecking {
//   static final InitialChecking _initialChecking = InitialChecking._init();

//   factory InitialChecking() {
//     return _initialChecking;
//   }

//   InitialChecking._init() {
//     getIsLogged();
//   }

//   late bool _isLogged;
//   late bool _isNotShowWelcome;

//   getIsLogged() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool? tempLogging = prefs.get(loggedKey) as bool?;
//     bool? tempFirstLog = prefs.get(isFirstLogin) as bool?;
//     if (tempLogging != null) {
//       _isLogged = tempLogging;
//     } else
//       _isLogged = false;

//     print("isLogged ${_isLogged}");

//     if (tempFirstLog != null) {
//       _isNotShowWelcome = tempFirstLog;
//     } else {
//       _isNotShowWelcome = false;
//     }
//   }

//   bool get isLogged => _isLogged;
//   bool get isNotShowWelcome => _isNotShowWelcome;

//   // await UserDb.instance.readAllcart().then((value) {
//   //   if (value.isEmpty) {
//   //     print("Database value Logged user is null");
//   //   } else {
//   //     print("Database value Logged user is " + value[0].id.toString());
//   //   }
//   // });

//   // if (tempLogging == null) {
//   //   isLogged = false;
//   // } else if (!tempLogging) {
//   //   isLogged = false;
//   // } else if (tempLogging) {
//   //   isLogged = true;
//   // } else {
//   //   isLogged = false;
//   // }

//   // if (tempFirstLog == null) {
//   //   isNotShowWelcome = false;
//   // } else if (!tempFirstLog) {
//   //   isNotShowWelcome = false;
//   // } else if (tempFirstLog) {
//   //   isNotShowWelcome = true;
//   // } else {
//   //   isNotShowWelcome = false;
//   // }
// }
