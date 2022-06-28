import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:shop_app/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/theme.dart';

import 'db/db_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isLogged;
  bool isNotShowWelcome;
  final prefs = await SharedPreferences.getInstance();
  bool? tempLogging = prefs.get(loggedKey) as bool?;
  bool? tempFirstLog = prefs.get(isFirstLogin) as bool?;
  if (tempLogging == null) {
    isLogged = false;
  } else if (!tempLogging) {
    isLogged = false;
  } else if (tempLogging) {
    isLogged = true;
  } else {
    isLogged = false;
  }

  if (tempFirstLog == null) {
    isNotShowWelcome = false;
  } else if (!tempFirstLog) {
    isNotShowWelcome = false;
  } else if (tempFirstLog) {
    isNotShowWelcome = true;
  } else {
    isNotShowWelcome = false;
  }
  runApp(MyApp(isLogged, isNotShowWelcome));
}

class MyApp extends StatelessWidget {
  bool existUser;
  bool notShowWelcomeScreen;
  MyApp(this.existUser, this.notShowWelcomeScreen);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(),
            lazy: true,
          ),
          BlocProvider(
            create: (context) => HomeBloc(),
            lazy: true,
          )
        ],
        child: existUser
            ? HomeScreen()
            : notShowWelcomeScreen
                ? SignInScreen()
                : SplashScreen(),
      ),

      // We use routeName so that we dont need to remember the name
      // initialRoute: existUser
      //     ? HomeScreen.routeName
      //     : notShowWelcomeScreen
      //         ? SignInScreen.routeName
      //         : SplashScreen.routeName,
      routes: routes,
    );
  }
}
