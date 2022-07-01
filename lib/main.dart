import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:shop_app/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/db/database.dart';
import 'package:shop_app/db/userDB.dart';
import 'package:shop_app/router/routes.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/util/size_config.dart';
import 'package:shop_app/util/theme.dart';
import 'package:shop_app/util/connection_util.dart';
import 'package:shop_app/util/connectivity_provider.dart';

import 'db/db_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isLogged;
  bool isNotShowWelcome;
  final prefs = await SharedPreferences.getInstance();
  await UserDb.instance.readAllcart().then((value) {
    if (value.isEmpty) {
      print("Database value Logged user is null");
    } else {
      print("Database value Logged user is " + value[0].id.toString());
    }
  });
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

class MyApp extends StatefulWidget {
  bool existUser;
  bool notShowWelcomeScreen;
  MyApp(this.existUser, this.notShowWelcomeScreen);

  @override
  State<MyApp> createState() => _MyAppState();
}

var _connectionStatus = 'Unknown';
late bool isConnected;

class _MyAppState extends State<MyApp> {
  late Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> _subscription;
  @override
  void initState() {
    // connectivity = new Connectivity();
    // _subscription =
    //     connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    //   _connectionStatus = result.toString();
    //   print(_connectionStatus);
    //   if (result == ConnectivityResult.none) {
    //     setState(() {
    //       isConnected = false;
    //     });
    //   } else {
    //     setState(() {
    //       isConnected = true;
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    // MyDatabase.instance.close();
    // _subscription.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: widget.existUser
      //     ? HomeScreen()
      //     : widget.notShowWelcomeScreen
      //         ? SignInScreen()
      //         : SplashScreen(),

      // We use routeName so that we dont need to remember the name
      initialRoute: widget.existUser
          ? HomeScreen.routeName
          : widget.notShowWelcomeScreen
              ? SignInScreen.routeName
              : SplashScreen.routeName,
      routes: routes,
    );
  }
}
