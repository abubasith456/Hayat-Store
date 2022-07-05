import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:shop_app/router/auto_routes.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/bloc/my_app_bloc/bloc/my_app_bloc.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
// import 'package:shop_app/router/auto_routes.gr.dart';
import 'package:shop_app/router/routes.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/util/secure_storage.dart';

import 'package:shop_app/util/theme.dart';
import 'constants.dart';
import 'util/init_check.dart';
// import './screens/home/home_screen.dart';

class MyApp extends StatefulWidget {
  MyApp({required this.isLogged});
  late bool isLogged;
  final storage = GetStorage();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String seen = widget.storage.read('seen') ?? '';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hayat Shop',
      theme: theme(),
      initialRoute: widget.isLogged
          ? HomeScreen.routeName
          : seen == 'yes'
              ? SignInScreen.routeName
              : SplashScreen.routeName,
      routes: routes,
    );
  }
}
