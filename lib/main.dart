import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/theme.dart';

import 'db/db_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var _userService = UserService();
  bool isLogged;
  var savedUser = _userService.readAllUsers();
  if (savedUser == null)
    isLogged = false;
  else
    isLogged = false;
  runApp(MyApp(isLogged));
}

class MyApp extends StatelessWidget {
  bool existUser;
  MyApp(this.existUser);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: existUser ? HomeScreen.routeName : SplashScreen.routeName,
      routes: routes,
    );
  }
}
